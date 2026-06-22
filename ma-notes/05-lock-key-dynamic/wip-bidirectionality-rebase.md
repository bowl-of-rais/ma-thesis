
```html
<UTooltip
        v-if="getSelectedEdges.length === 1"
        :text="getSelectedEdges[0]!.data.bidirectional ? 'Make Unidirectional' : 'Make Bidirectional'"
        :content="{ align: 'center', side: 'right' }"
      >
        <UButton size="xl" :icon="getSelectedEdges[0]!.data.bidirectional ? 'i-lucide-move-horizontal' : 'i-lucide-move-right'" color="primary" @click="changeEdgeDirectionality(getSelectedEdges[0]!.id)" />
      </UTooltip>
```
