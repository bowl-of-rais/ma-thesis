based on
- [[02-diagram]]
- [[03-basic-improvements]]

## Diagram generation

### Functionality

- expandable element for usability: users can hide diagrams while working on statechart
- can create multiple diagrams and remove diagrams (red because diagrams do not persist)

![[Pasted image 20260218205459.png]]

- selection of one or multiple component definitions for the y axis
- optionally selection of one component for the x axis (e.g. estimated playtime)
	- values are summed up along selected path
	- default: equal spacing

![[Pasted image 20260218205536.png]]

- selected path along x axis
	- if no path selected: all nodes - TODO: sorting

| Path from Beat to Beat | No Path Selected |
| ----------------------- | -------------------------------- |
| ![[Pasted image 20260218205602.png]] | ![[Pasted image 20260218205618.png]] |

### Implementation

- [chartJS](https://www.chartjs.org/docs/latest/) library
- modular architecture: `PxDiagrams` as wrapper element
	- manages diagrams
		- currently: passes path (reactively), deletes diagrams
		- future work: path snapshots, different data types
- data is extracted from nodes once per diagram, switching between axis configurations is then done via different parsing configurations

### Workflow

1. add new diagram
2. in any order:
	- select one or no component for x axis
	- select one or more component for y axis
	- select path

-> changes in any of the configurations will be reflected live in the diagram

### Limitations

- diagrams do not persist (reset when reloading page)
- only line diagrams for now
- same path selection for all diagrams
