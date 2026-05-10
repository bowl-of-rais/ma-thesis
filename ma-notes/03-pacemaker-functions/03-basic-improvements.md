---
start: 2025-12-15
end: 2025-12-31
tags:
  - "#implementation"
milestone: 26_01
---

see [[03-pacemaker-functions/thoughts|thoughts]]

## Errors

- [ ] error handling

- no path found

```
  <UCard class="min-h-55">
```
## Functionality

- [/] selection for x axis (-> estimated playtime)
	- "When `data` is an array of arrays (or what TypeScript would call tuples), the first element of each tuple is the index (`x` for vertical, `y` for horizontal charts) and the second element is the value (`y` by default)."
	- [x] add another selector ✅ 2026-01-26
	- [x] pass selection to diagram ✅ 2026-01-26
	- [x] generate data accordingly: sum estimated playtimes ✅ 2026-01-30
	- [ ] filter for number types?
	- [ ] add labels
	- [ ] remove selection? -> none?

- screenshot: initial version
	![[Pasted image 20260130110029.png|420]]

use [parsing mode](https://www.chartjs.org/docs/latest/general/data-structures.html#parsing) for cleaner data:

```ts fold
const data = [
	{
		name: 'Node Name',
		component1: 0,
		...
	}
]

const datasetCfg = {
	label: 'componentName',
	data: data,
	parsing: {
		xAxisKey:  // name if no x axis, otherwise component
		yAxisKey:  // component
	}
}
```

-> need names of 

```json fold
datasets = [
	{
		"label":"Difficulty",
		"data":[
			{
				"name":"Beat 1",
				"x":1,
				"5bb92a28-5257-4124-833e-af7f9cdfe070":1
			},{
				"name":"Beat 2",
				"x":2,
				"5bb92a28-5257-4124-833e-af7f9cdfe070":2
			},{
				"name":"Beat 3",
				"x":5,
				"5bb92a28-5257-4124-833e-af7f9cdfe070":2
			},{
				"name":"Beat 4",
				"x":7,
				"5bb92a28-5257-4124-833e-af7f9cdfe070":2
			},{
				"name":"Beat 5",
				"x":8,
				"5bb92a28-5257-4124-833e-af7f9cdfe070":1
			}
		],
		"parsing":
			{
				"xAxisKey":"f9e4e403-aac5-4fce-9eec-d4dbca78bdcb",
				"yAxisKey":"5bb92a28-5257-4124-833e-af7f9cdfe070"
			},
		"stepped":"after",
		"fill":true,
		"borderColor":"#06b6d4"
	}
]

```

```json fold
[
	{
		"label":"Difficulty",
		"data":
			[
				{
					"name":"Beat 1",
					"5bb92a28-5257-4124-833e-af7f9cdfe070":1
				},{
					"name":"Beat 2",
					"5bb92a28-5257-4124-833e-af7f9cdfe070":2
				},{
					"name":"Beat 3",
					"5bb92a28-5257-4124-833e-af7f9cdfe070":2
				},{
					"name":"Beat 4",
					"5bb92a28-5257-4124-833e-af7f9cdfe070":2
				},{
					"name":"Beat 5",
					"5bb92a28-5257-4124-833e-af7f9cdfe070":1
				}
			],
		"parsing":
			{
				"yAxisKey":"5bb92a28-5257-4124-833e-af7f9cdfe070"
			},
		"stepped":false,
		"fill":true,
		"borderColor":"#06b6d4"
	}
]
```

debugging:
- [p] set x then y
- [p] set y then x then y
- [c] set y then x 
-> only changes in Y seem to update computed

- when using a simple (non-reactive) object as `chartOptions` : data is shown when setting y then x, but: axis is not updated (still categorical)  

![[Pasted image 20260202173356.png]]

- [ ] expand on data types
	- [ ] categorical/strings: bar chart like in PaceMaker?
	- [ ] boolean: 
	- [ ] sparate selection based on data type
- [x] multiple diagrams ✅ 2026-01-15
- [x] paths between more than 2 nodes ✅ 2026-02-17
	- [x] check implementation in pacemaker ✅ 2026-02-17
	- in pacemaker: selection passed as array, then dijkstra between subsequent pairs of nodes, i.e. selection order determines path
- [-] multiple paths/snapshot functionality -> rather out of scope
- [x] multiple components ⏳ 2026-01-23 ✅ 2026-01-23
	- multiple colors
- [ ] missing values?

- [/] changes to statechart should be reflected in diagrams immediately 🛫 2026-03-04 
	- [x] adding/deleting of nodes -> only reflect nodes present in the statechart?? ✅ 2026-03-04
	- [x] reflect containers without nodes in diagrams ✅ 2026-03-04
	- [ ] reflect changes in components and componentdefinitions as well
	- [ ] depending on used mechanism, also re-trigger pathfinding when edges are added
		- [ ] also highlight edges

## Styling and UX


- [x] make diagram section collapsible ✅ 2026-01-15
- [x] make diagrams wider in size (currently dependent on `SimpleCardSection`) ✅ 2026-02-09
- [x] better highlighting ✅ 2026-01-16
- [x] prevent toast message for highlighting (maybe implement highlighting differently) ✅ 2026-01-16
- [ ] wrap in scrollArea (added in [v4](https://github.com/nuxt/ui/pull/5245))

