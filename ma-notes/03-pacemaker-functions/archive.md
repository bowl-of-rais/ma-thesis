# Code Archive

## Legacy Highlighting

```js title='usePxChartsCanvasApi'
  async function updateContainerHighlight(containerId: string, value: boolean) {
    const updatedPxGraphContainerContent = {
        id: containerId,
        highlighted: value,
    }
    try {
      await updateContainer(updatedPxGraphContainerContent)
    } catch (err) {
      alert('Failed to highlight container: ' + err.message)
      error.value = 'Failed to highlight container'
    }  
  }
```

-> called in `highlightPath` and `resetPath`

```js title='PxChartContainer'

const isHighlighted = ref({
    hl: props.data.highlighted
})
const highlightClass = ref('green'
    //{
    //background: 'info'
//}
)

watch(isHighlighted.value, (newValue) => {
    alert('highlight updated!')
    if (newValue.hl) {
        highlightClass.value = 'green'
    } else {
        highlightClass.value = 'blue'
    }
})
```

```ts title='px.d.ts'
interface PxChartContainer {
  id: string
  name: string
  content: string | null
  type: PxContainerContentType
  layout: PxChartContainerLayout
  px_chart: string
  owner: number | null
  created_at: string
  updated_at: string
  highlighted: boolean
}
```

## Legacy Data Calculation

```js
const data = computed(() => {
  const labels : string[] = []

  let relevantNodes = props.nodesInPath
    .map((name) => getNodeFromName(name))
    .filter((node) => node !== undefined)
  if (!relevantNodes.length)
    relevantNodes = pxNodes.value
  // console.log(`Nodes: [${relevantNodes.toString()}]`)

  relevantNodes.forEach((node) => {
    labels.push(node.name)
  })

  const datasets = []
  const colors = initColorIterator()
/*
  if (selectedDefinitionsX.value) {
    selectedDefinitionsY.value.forEach((def) => {
    const values: number[][] = []
    let sumX: number = 0
    relevantNodes.forEach((node) => {
        const yValue = pxComponents.value
            .find((c) => c.definition === def && c.node === node.id)?.value
        const xValue = pxComponents.value
            .find((c) => c.definition === selectedDefinitionsX.value && c.node === node.id)?.value
        if (typeof xValue === 'number') {
            sumX += xValue ? xValue : 0
        }
        if (typeof yValue === 'number') {
            values.push([sumX, yValue])
        } else {
            values.push([sumX, NaN])
        }
    })
    datasets.push({
        label: getNameFromDefinitionId(def),
        data: values,
        fill: true,
        borderColor: colors.next().value
    })
  })
  } else {
    selectedDefinitionsY.value.forEach((def) => {
    const values: number[] = []
    relevantNodes.forEach((node) => {
        const yValue = pxComponents.value
            .find((c) => c.definition === def && c.node === node.id)?.value
        if (typeof yValue === 'number') {
            values.push(yValue)
        } else {
            values.push(NaN)
        }
    })
    datasets.push({
        label: getNameFromDefinitionId(def),
        data: values,
        fill: true,
        borderColor: colors.next().value
    })
  })
    */

  selectedDefinitionsY.value.forEach((def) => {
    const valuesWithX : object[] = []
    const valuesWithoutX : number[] = []
    const values : object[] = []
    let sumX: number = 0
    relevantNodes.forEach((node) => {
        const yValue = pxComponents.value
            .find((c) => c.definition === def && c.node === node.id)?.value
        const xValue = pxComponents.value
            .find((c) => c.definition === selectedDefinitionsX.value && c.node === node.id)?.value
        if (typeof xValue === 'number') {
            sumX += xValue
            if (typeof yValue === 'number') {
                valuesWithX.push({x: sumX, y: yValue})
                values.push({x: sumX, y: yValue})
            } else {
                valuesWithX.push({x: sumX, y: null})
                values.push({x: sumX, y: null})
            }
        } else {
            if (typeof yValue === 'number') {
                valuesWithoutX.push(yValue)
                values.push({x: node.name, y: yValue})
            } else {
                valuesWithoutX.push(NaN)
                values.push({x: node.name, y: NaN})
            }
        }
        
    })
    // valuesWithX.forEach((pair) => alert(pair.toString()))
    datasets.push({
        label: getNameFromDefinitionId(def),
        //data: selectedDefinitionsX.value ? valuesWithX : valuesWithoutX,
        data: values,
        stepped: selectedDefinitionsX.value ? 'after' : false,
        fill: true,
        borderColor: colors.next().value
    })
  })
  //console.log(`Labels: [${labels.toString()}]`)
  
  return selectedDefinitionsX.value  ? 
    {
        datasets: datasets
    } 
    : 
    {
        labels: labels,
        datasets: datasets
    }
})
```

```html title="clear selection button"
<UButton
                aria-label="Clear"
                color="neutral"
                variant="subtle"
                icon="i-lucide-rotate-ccw"
                @click="resetY"
            />  
```

