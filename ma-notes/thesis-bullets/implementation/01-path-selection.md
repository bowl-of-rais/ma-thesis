## Path Selection
### Functionality

- selection of nodes triggers calculation of path connecting them
- selected path is highlighted (visual feedback)
- path is subsequently used for diagram generation

### Implementation

- select start + end node, optionally intermediate -> calculate path using dijkstra
- `pathsApi.ts`: to allow for different algorithms in the future (e.g. specific pathfinding for nestedness and concurrency)

### Workflow

- selection of at least two nodes
	- Ctrl + click
- path is calculated along nodes *in order of selection*
- if path is found, the corresponding nodes are highlighted
- path can be de-selected by removing node selection (clicking anywhere)

![[Pasted image 20260218204841.png]]
