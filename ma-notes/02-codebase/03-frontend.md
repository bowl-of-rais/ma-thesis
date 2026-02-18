---
start: 2025-11-21
end: 2025-11-23
tags:
  - task
milestone: 2512
---

-> [[FRONTEND.canvas|FRONTEND]]

- [x] Vue.js [tutorial](https://vuejs.org/tutorial/#step-1) ✅ 2025-11-23
- [x] understand hierarchy of relevant files ✅ 2025-11-21
- [x] understand what each is for ✅ 2025-11-23

## Hierarchy

### `components/`


```mermaid
graph TD
	c1(PxChart<br>Canvas) --> c2(PxChart<br>Container)
	c1 --> c3(PxChartEdge)
	c1 --> c4(PxChart<br>ContainerNode)
	c2 --> c5(PxChartContainer<br>AddPxNodeForm)
```

- `PxChartContainer` : used on overview page
- `PxChartContainerNode`: used on canvas/chart

### `composables/`

#### `usePxChartsCanvasApi`

```mermaid
graph TD
	c1(usePxChartsCanvasApi) --> c2(usePxCharts)
	c1 --> c3(usePxChartContainers)
	c1 --> c4(usePxChartEdges)
```

- has `nodes`, `edges`, `loading`, `error`
- default values for containers, edges
- `loadGraph`
- `addContainer`
- `updateContainer`
- `addNodeToContainer`
- `removeNodeFromContainer`
- `deleteContainer`
- `addEdge`
- `deleteEdge`

### `pages/`

#### `pxcharts/[id].vue`

- page for specific chart

#### `pxcharts/index.vue`

- overview page over all charts