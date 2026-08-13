#import "../utils.typ": todo
#import "../bib.typ": load-bib

= Path-Based Diagrams <impl-diagrams>

The basic idea for path-based diagrams was already presented in PaceMaker.
Users were able to select a path in the statechart and visualize data along the path.
PaceMaker offered a range of pre-defined player experience properties that could be represented in the chart (e.g., gameplay intensity or expected playtime).
In contrast, pix:e has been implemented with so-called `PxComponent`s, which allow users to define their own properties with a name and data type.
This highly configurable approach was used as a central guideline for the implementation of path-based diagrams in pix:e.

The following sections describe the functionalities, implementation choices and intended workflow/usage of path-based diagrams in pix:e.

== Initial State of the System

#todo("introduce components, nodes/pxchart")

== Requirements

based on PaceMaker:

path selection
	- start/intermediate/end beats -> Dijkstra
	- path snapshots
	- implementation in p:xe part of this work

pacing diagrams
	- visualize intensity or gameplay category per beat
	- in pix:e: selection based on PxComponents
  - comparison of different properties per beat
  - comparison of different paths

- expansion to variable components: allows for modeling of more than just player experience. pacing -> line is blurry.

== Path Selection

This subsection describes the implementation and usage of the path selection functionality.

=== Functionality

- selection of nodes in statechart triggers calculation of path connecting them
- selected path is highlighted (visual feedback)
- path is subsequently used for diagram generation

#figure(
  image("assets/03/high-level-path-calculation.drawio.png", width: 90%),
  caption: "High-Level Logic for Pathfinding"
)

=== Implementation

The `usePxChartPathCalculation.ts` composable encapsulates path calculation logic.
The initial implementation uses Dijkstra's algorithm to calculate the shortest path between the selected nodes.
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
2. If a path exists that connects the nodes, all nodes along the path are highlighted in purple (see @fig:path-hl). If not, the start and end nodes are highlighted in red.
3. Finally, the path can be de-selected by clicking anywhere outside the nodes. This removes the node selection and any highlighting.

If more than two nodes are selected, the path is calculated along all selected nodesin order of selection.
This allows users to explore alternative paths to the shortest path.

#figure(
  image("assets/03/path-selected-highlight.png"),
  caption: [Path highlighted in state chart],
) <fig:path-hl>

=== Limitations

One limitation of this implementation is that paths are not persisted in any way. #todo("consequence?")

Additionally, there is no visual feedback for the order in which nodes were selected, i.e., what input the path calculation uses.

== Diagram Generation

This subsection describes the implementation and usage of the diagrams feature.

=== Functionality

- expandable element on statechart page
  - usability: users can hide diagrams while working on statechart
- can create multiple diagrams and remove diagrams (red because diagrams do not persist)

#figure(
  image("assets/03/diagram-expandable-addable.png"),
  caption: [Upper section of the charts page with expandable element and UI for diagram creation],
) <fig:diagram-area>

- selection of one or multiple component definitions for the y axis
- optionally selection of one component for the x axis (e.g. estimated playtime)
	- values are summed up along selected path
	- default: equal spacing

#figure(
  image("assets/03/diagram-axis-selection.png"),
  caption: [Selectors for components to be mapped to X/Y axes],
) <fig:axis-sel>

- selected path along x axis
	- if no path selected: all nodes, in no specific order

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

=== Implementation

- #link("https://www.chartjs.org/docs/latest/")[chartJS] library
- modular architecture: `PxDiagrams` as wrapper element
	- manages diagrams
		- currently: passes path (reactively), deletes diagrams
		- future work: path snapshots, different data types
- data is extracted from nodes once per diagram, switching between axis configurations is then done via different parsing configurations

=== Workflow

1. add new diagram
2. in any order:
	- select one or no component for x axis
	- select one or more component for y axis
	- select path

- changes in any of the configurations will be reflected live in the diagram

=== Limitations

- diagrams do not persist (reset when reloading page)
- only line diagrams for now
- same path selection for all diagrams, no snapshots

#load-bib()