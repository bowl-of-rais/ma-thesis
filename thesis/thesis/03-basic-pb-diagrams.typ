#import "../utils.typ": todo
#import "../bib.typ": load-bib

= Pacing Analysis Using Path-Based Diagrams <impl-diagrams>

PaceMaker already presented a protoype for pacing diagrams.
Users were able to select a path in the statechart, and visualize data along the path.
PaceMaker offered a range of pre-defined player experience properties that could be represented in the chart (e.g., gameplay intensity or expected playtime).
In contrast, pix:e allows users to define and create so-called `PxComponent`s, which may be used to represent a variety of player experience, pacing, and gameplay aspects.
This highly configurable approach was used as a central guideline for the implementation of path-based diagrams in pix:e.

The following sections describe the functionalities, implementation choices and intended workflow/usage of path calculation and path-based pacing analysis diagrams in pix:e.

== Pre-Existing Functionalities in pix:e <initial-pixie>

At the start of this implementation, pix:e included a player experience module with a so-called `PxChart`.
Analogously to PaceMaker, a `PxChart` is a statechart in which users can structurally model how players progress through a game.

#todo("screenshot of initial statechart if possible")

Nodes in `PxChart`s (so-called `PxNodes`) are given a name and description and can be connected via edges.
As pix:e does not have pre-defined node properties, users first need to create `PxComponentDefinition`s, which specify the name (e.g., "Intensity") and the data type (one of "number", "string", "boolean") of a property.
They may then add a `PxComponent` to a node by selecting the desired definition and specifying its value for the node in question as seen in @component-creation-modal.

#figure(
  image("assets/03/component-creation-modal.png", width: 50%),
  caption: "pix:e's component creation modal"
) <component-creation-modal>

#todo("tech stack: vue/nuxt/VueFlow in frontend, django in backend. explain what composables and components are")

== Requirements <diagrams-requirements>

To implement the functionalities available in PaceMaker in pix:e, two main elements are required. #todo("A")

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

This subsection describes the scope, implementation and usage of the path selection functionality.

=== Functionality

To support an interactive user experience, any (multi-)selection of nodes in the statechart triggers the search for the shortest path that connects all selected nodes in order of selection.
This allows users to influence the course of the path and explore alternatives to the actual shortest path from the start node to the target node.

The result is conveyed to the user in two different ways: via highlighting of nodes and a temporary pop-up message (i.e., a toast notification).
In case of successful pathfinding, the associated nodes are highlighted in purple (primary color in the CSS theme) and a success toast is displayed.
For unsuccessful pathfinding, the selected nodes are highlighted in red (error color in the CSS theme) and an info toast is displayed. 

#figure(
  image("assets/03/high-level-path-calculation.drawio.png", width: 90%),
  caption: "High-Level Logic for Pathfinding"
)

#todo("adapt diagram: select 2+ nodes -> detect selection of 2+ nodes, consistent subject")

=== Implementation

All path calculation is encapsulated in a dedicated composable (`usePxChartPathCalculation.ts`).
The initial implementation uses Dijkstra's algorithm with a priority queue to calculate the shortest path between the selected nodes.
Given the nodes and edges present in a chart, the composable provides the following functions:
- `calculatePathFromSelection()` calculates path from selected nodes and stores result internally
- `resetPathCalculation()` resets the stored result
- `updateNodeStyling()` updates highlighting in the chart based on stored result

Node selection is detected in the main chart component (`PxChartCanvas.vue`).
Whenever a updated selection of 2 or more nodes is detected, the path calculation function is re-triggered.
Conversely, an updated selection of 0 nodes resets the calculated path and removes any highlighting.

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

One limitation of this implementation is that calculated paths are not persisted in any way. #todo("consequence?")

Additionally, there is no visual feedback for the order in which nodes were selected, i.e., what input the path calculation uses.

== Diagram Generation

This subsection describes the scope, implementation and usage of the diagrams feature.

=== Functionality

Diagrams are available within an expandable element on a `PxChart` page.
This choice was made to allow users to hide the diagrams while working on the statechart itself.
The implementation supports the creation of multiple diagrams to display and compare different configurations.
Individual diagrams can be removed as well.

#figure(
  image("assets/03/diagram-expandable-addable.png"),
  caption: [Upper section of the charts page with expandable element and UI for diagram creation],
) <fig:diagram-area>

#h(1.8em)
This implementation focuses specifically on line diagrams displaying numerical data.
The main configuration options for line diagrams are the two axes.
For the vertical x-axis, one or more numerical components may be selected in a drop-down menu to visualize the values for each node.

By default, the nodes in a selected path --- or, if no path is selected, all existing nodes --- are arranged equidistantly on the horizontal y-axis.
By default, the nodes are arranged equidistantly.pix
However, the spacing of nodes on the y-axis can optionally be configured to be based on a component.
In this case, the values of the component are summed up along the selected path or across all nodes, resulting in variable distances.
This configuration can be used when components are used to model data related to the timing of player progression through a game, e.g., estimated playtime.
The components selected for the x-axis are then visualized along the path based on said progression metric.

=== Implementation

Diagrams are created dynamically using the chartJS #footnote[#link("https://www.chartjs.org/docs/latest/")] library.
The architecture is modular and uses a wrapper component called `PxDiagrams`.
It passes the currently selected path to the individual diagrams (currently implemented as individual `PxLineDiagram` components) reactively and manages deletion of diagrams.
//- future work: path snapshots, different data types
// The data is extracted from the nodes once per diagram.
The axis configurations are passed on to chartJS to control which components are visualized and how.

=== Workflow

For the diagram generation, the intended workflow is as follows:

1. Creation of a new diagram by clicking the "+" panel.
2. In no particular order:
	
	- Selection of one or more components for the y axis via drop-down menu
	- Optionally: Selection of a component for the x axis drop-down menu
	- Selection of a path as previously described

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
//#cite(<dyrdaPacingDiagramStep2026>) present a formalization of pacing diagrams that may be suitable to this end.

Secondly, as paths are currently not persisted in any way, only one calculated path is available for diagram generation at a time.
Consequently, all diagrams on a chart page are based on the same path.
While real-time switching between different paths is possible, a direct comparison of values between different paths is therefore not directly.

Lastly, diagrams are not persisted either and reset when reloading a page.
This may negatively impact user experience as diagrams need to be configured repeatedly.

#load-bib()