#import "../utils.typ": todo
#import "../bib.typ": load-bib

= Pacing Analysis Using Path-Based Diagrams <impl-diagrams>

PaceMaker already presented a protoype for pacing diagrams.
Users were able to select a path in the statechart, and visualize data along the path.
PaceMaker offered a range of pre-defined player experience properties that could be represented in the chart (e.g., gameplay intensity or expected playtime).
In contrast, pix:e allows users to define and create so-called `PxComponent`s, which may be used to represent a variety of player experience, pacing, and gameplay aspects.
This highly configurable approach was used as a central guideline for the implementation of path-based diagrams in pix:e.

The following sections describe the functionalities, implementation choices and intended workflow/usage of path calculation and path-based pacing analysis diagrams in pix:e.

== Initial State of the System <initial-pixie>

The starting point of this implementation was the existing `PxChart` in pix:e: a statechart in which users could model a game's structure.
Nodes in `PxChart`s (so-called `PxNodes`) are given a name and description.

#todo("screenshot of initial statechart if possible")

As pix:e does not have pre-defined node properties, users first need to create `PxComponentDefinition`s, which specify the name (e.g., "Intensity") and the data type (one of "number", "string", "boolean") of a property.
They may then add a `PxComponent` to a node by selecting the desired definition and specifying its value for the node in question.

#todo("screenshot of component creation if possible")

#todo("tech stack: vue/nuxt/VueFlow in frontend, django in backend.")

== Requirements <diagrams-requirements>

To transport the features available in PaceMaker to pix:e, two main elements needed to be implemented.

The first part concerns path calculation based on the statechart.
Users should be able to specify start and end nodes (optionally: intermediate nodes) as inputs to the path calculation.
The system should then communicate the result to users, i.e., whether a path exists that connects the specified nodes and if so, how the calculated path runs through the chart.
// - path snapshots #todo("maybe not mention here as it was not implemented?")

The second element is the visualization of data along a selected path in diagrams.
As described previously, pix:e offers users to customize which data is assigned to nodes by defining `PxComponent`s.
Users should thus be able to configure which of the available `PxComponent`s is visualized and how.
Ideally, this would enable users to compare different properties per node and compare different paths.

#todo("expansion to variable components -> now modeling more than just player experience is possible. line to pacing is blurry. explain this here or elsewhere?")

== Path Selection

This subsection describes the extent, implementation and usage of the path selection functionality.

=== Functionality

To #todo("reasoning"), any (multi-)selection of nodes in the statechart triggers the calculation of a connecting path.

The result is feedbacked to the user in two different ways: via highlighting of nodes and a toast message.
In case of successful pathfinding, the associated nodes are highlighted in purple (primary color in the CSS theme) and a success toast is displayed.
For unsuccessful pathfinding, the start and end nodes are highlighted in red (error color in the CSS theme) and an info toast is displayed. 

#figure(
  image("assets/03/high-level-path-calculation.drawio.png", width: 90%),
  caption: "High-Level Logic for Pathfinding"
)

#todo("adapt diagram: select 2+ nodes -> detect selection of 2+ nodes, consistent subject")

=== Implementation

The `usePxChartPathCalculation.ts` composable encapsulates all path calculation logic.
The initial implementation uses Dijkstra's algorithm with a priority queue to calculate the shortest path between the selected nodes.
Given the nodes and edges present in a chart, the composable provides the following functions:
- `calculatePathFromSelection()`: calculates path from selected nodes and store result internally
- `updateNodeStyling()`: updates highlighted path based on stored result
- `resetPathCalculation()`: resets result

Node selection is detected in the main chart component (`PxChartCanvas`), from which the path calculation function is called.
Each change in node selection triggers a re-calculation of the path.
A reset of the node selection (= 0 nodes selected) also removes any highlighting.

=== Workflow

The intended workflow/usage is as follows:

1. Selection of at least two nodes via `Ctrl + click`
  
  - If a path exists that connects the nodes, all nodes along the path are highlighted in purple (see @fig:path-hl).
  - If not, the start and end nodes are highlighted in red.

2. The path can be de-selected by clicking anywhere outside the nodes. This removes the node selection and any highlighting.

If more than two nodes are selected, the path is calculated along all selected nodes in order of selection.
This allows users to explore alternative paths to the shortest path.

#figure(
  image("assets/03/path-selected-highlight.png"),
  caption: [Path highlighted in state chart],
) <fig:path-hl>

=== Limitations

One limitation of this implementation is that paths are not persisted in any way. #todo("consequence?")

Additionally, there is no visual feedback for the order in which nodes were selected, i.e., what input the path calculation uses.

== Diagram Generation

This subsection describes the extent, implementation and usage of the diagrams feature.

=== Functionality

Diagrams are available within an expandable element on statechart page.
This choice was made to allow users to hide the diagrams while working on the statechart itself.
The implementation supports the creation of multiple diagrams to diplay and compare different configurations.
Individual diagrams can be removed as well.

#figure(
  image("assets/03/diagram-expandable-addable.png"),
  caption: [Upper section of the charts page with expandable element and UI for diagram creation],
) <fig:diagram-area>

#h(1.8em)
This implementation focuses specifically on line diagrams displaying numerical data.
The main configuration options for line diagrams are the two axes.
For the x-axis, one or more numerical components may be selected in a drop-down menu to visualize the values for each node.

By default, the nodes in a selected path are arranged equidistantly on the y-axis.
If no path is selected, all nodes in the statechart are represented on the y-axis.
However, the spacing of nodes on the y-axis can optionally be configured to be based on a component.
In this case, the values of the component are summed up along the selected path or across all nodes, resulting in variable distances.
This functionality can be used when components are used to model data related to players' progression through a game, e.g., estimated playtime.
The components selected for the x-axis are then visualized along the path based on said progression metric.

=== Implementation

Diagrams are created dynamically using the chartJS #footnote[#link("https://www.chartjs.org/docs/latest/")] library.
The architecture is modular and uses a wrapper component called `PxDiagrams`.
It passes the currently selected path to the individual diagrams (currently implemented as individual `PxLineDiagram` components)
reactively and manages deletion of diagrams.
//- future work: path snapshots, different data types
The data is extracted from the nodes once per diagram.
The axis configurations then determine how the extracted data is parsed. is then done via different parsing configurations

=== Workflow

For the diagram generation, the intended workflow is as follows:

1. Creation of a new diagram.
2. In no particular order:
	
	- Selection of one or more component for y axis
	- (Optionally:) Selection of one or no component for x axis
	- Selection of a path

Any changes in the diagram configuration or path selection are reflected in the diagram in real time.

#figure(
  image("assets/03/diagram-axis-selection.png"),
  caption: [Selectors for components to be mapped to X/Y axes],
) <fig:axis-sel>

#grid(
  columns: 2,
  gutter: 1em,
  figure(
    image("assets/03/diagram-selected-path.png"),
    caption: [Diagram visualizing component along selected path]
  ),
  figure(
    image("assets/03/diagram-all-nodes.png"),
    caption: [Diagram visualizing component across all nodes]
  )
)

#todo("replace with screenshots of larger statechart, show chart itself and corresponding diagrams")

#todo("screenshot of diagram with configured y-axis")

=== Limitations

The current implementation of path-based diagrams has several limitations.

Firstly, only line diagrams are supported for now.
This enables the analysis of numerical `PxComponent`s along different paths.
Textual and boolean data types cannot yet be visualized.
However, the current modular implementation is designed to be extendable to different diagram types.
A possible other visualization as implemented in PaceMaker are stacked bar charts for categorical (i.e., textual) data.
Boolean data could either be mapped to numerical values or, when visualized with other data types, be represented by different point shapes (e.g., circles vs squares).
Overall, the flexibility of `PxComponent`s results in a variety of possible visualizations. 
Further investigation is needed to determine how this high degree of customizability is best translated into a diagram configuration UI.
//#cite(<dyrdaPacingDiagramStep2026>) present a formalization of pacing diagrams that may be suitable to this end.

Secondly, as paths are currently not persisted in any way, only one calculated path is available for diagram generation at a time.
Consequently, all diagrams on a chart page are based on the same path.
A comparison of values between different paths is thus only possible sequentially.

Lastly, diagrams are not persisted either and reset when reloading a page.
An option to save diagram configurations would likely improve the user experience and enable users to consistently analyze their data over the course of a project.


#load-bib()