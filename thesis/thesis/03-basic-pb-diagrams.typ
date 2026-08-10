#import "../utils.typ": todo
#import "../bib.typ": load-bib

= Path-Based Diagrams <impl-diagrams>

#todo("potentially refactor: 1 chapter for implementation, provide context (tech stack etc)")

- basic idea already present in PaceMaker: select path in statechart and visualize data along path
- main design guideline: build upon high configurability already present in the system
- following sections describe functionalities, implementation choices and wokflow/usage of these features implemented in pixe

== Initial State of the System

#todo("introduce components, nodes/pxchart")

== Path Selection

=== Functionality

- selection of nodes in statechart triggers calculation of path connecting them
- selected path is highlighted (visual feedback)
- path is subsequently used for diagram generation

#figure(
  image("assets/03/high-level-path-calculation.drawio.png", width: 90%),
  caption: "High-Level Logic for Pathfinding"
)

=== Implementation

- `pathsApi.ts` composable encapsulates path calculation logic (= dijkstra)
  - allows for different algorithms in the future (e.g. specific pathfinding for nestedness and concurrency)
  - interface:
    - input nodes and edges (VueFlow), selected nodes
    - provided functions path calculation (includes toasting), highlighting, reset of result + highlight
- selection of start + end node (optionally intermediate nodes) detected in `PxChartCanvas` componend -> call path calculation function
- changing node selection triggers re-calculation
- resetting node selection (= 0 nodes selected) resets path calculation + highlight

=== Workflow

- selection of at least two nodes
	- Ctrl + click
- path is calculated along nodes *in order of selection*
- if path is found, nodes along the path are highlighted in purple. if not, start/end nodes are highlighted in red.
- path can be de-selected by removing node selection (clicking anywhere)

#figure(
  image("assets/03/path-selected-highlight.png"),
  caption: [Path highlighted in state chart],
) <fig:path-hl>

=== Limitations

- calculation fully done in frontend
- paths are not persisted
- no visual indicator for/distinction between start/end nodes

== Diagram Generation

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
- same path selection for all diagrams

#load-bib()