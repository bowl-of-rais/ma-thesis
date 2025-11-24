# About Vue.js

---
## Concepts
### Components
-> [docs](https://vuejs.org/guide/essentials/component-basics.html)

>Components allow us to split the UI into independent and reusable pieces, and think about each piece in isolation.

### Composables
-> [docs](https://vuejs.org/guide/reusability/composables.html)

> In the context of Vue applications, a "composable" is a function that leverages Vue's Composition API to encapsulate and reuse **stateful logic**.

---

## [`@vue-flow`](https://vueflow.dev/)

-> library for flowcharts and graphs

- [docs](https://vueflow.dev/guide/)


---
## Tutorial Notes

### Declarative Rendering
-> [guide on reactivity](https://vuejs.org/guide/essentials/reactivity-fundamentals.html)

**Single-File Component** (SFC): HTML + CSS + JavaScript

```vue title="SFC example"
<script setup>
import { ref } from 'vue'

// component logic
// declare some reactive state here.
</script>

<template>
  <h1>Make me dynamic!</h1>
</template>
```

>**declarative rendering**: using a template syntax that extends HTML, we can describe how the HTML should look based on JavaScript state. When the state changes, the HTML updates automatically.

- **reactive state** can be declared using `reactive(...)` on objects
- `ref()` takes any value type and creates an object that exposes the inner value under a `.value` property
- declare in script block, use in template (-> placeholder)
- placeholders in template can be any valid JavaScript expression

```vue title="Reactivity Example"
<script setup>
import { ref } from 'vue'

const num = ref(2)
</script>

<template>
	<h1>The number is {{ num }}!</h1>
</template>
```

### Attribute Bindings
-> [guide on template syntax](https://vuejs.org/guide/essentials/template-syntax.html)

- **v-bind directive**: for binding attributes to a dynamic value

```vue title="v-bind Syntax"
<!-- 'id' attribute of element synced to 'dynamicId' property from component's state -->
<div v-bind:id="dynamicId"></div>

<!-- shorthand-->
<div :id="dynamicId"></div>
```

- **directive**: special attribute, prefixed with `v-`
	- values: JavaScript expressions w/ access to component's state

```vue title="v-bind example"
<script setup>
import { ref } from 'vue'

const titleClass = ref('title')
</script>

<template>
  <h1 :class="titleClass">Make me red</h1> <!-- add dynamic class binding here -->
</template>

<style>
.title {
  color: red;
}
</style>
```

- [i] [overview of HTML attributes](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes)

### Event Listeners

- **v-on** directive: used to listen to [DOM events](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model/Events)

- [i] **DOM (= Document Object Model) events**: changes that may affect code execution 

```vue title="v-on Syntax"
<!-- references function `increment()` in script part -->
<button v-on:click="increment">{{ count }}</button>
<button @click="increment">{{ count }}</button>
```

```vue title="v-on Example"
<script setup>
import { ref } from 'vue'

const count = ref(0)

function increment() {
  count.value++
}
</script>

<template>
  <button @click="increment" >Count is: {{ count }}</button>
</template>
```

### Form Bindings
-> [guide on form input bindings](https://vuejs.org/guide/essentials/forms.html)

- `v-bind` and `v-on` can be combined to create 2-way bindings -> form input elements

```vue title="Two-way binding"
<input :value="text" @input="onInput">
```

- **v-model** directive: syntactic sugar for two-way bindings
	- syncs input value with bound state
	- removes need for event handler (`@input`)

```vue title="v-model Syntax"
<input v-model="text">
```

### Conditional Rendering
-> [guide on conditional rendering](https://vuejs.org/guide/essentials/conditional.html)

```vue title="v-if Syntax"
<h1 v-if="awesome">Vue is awesome!</h1>
<h1 v-else>Oh no 😢</h1>
```

### List Rendering
-> [guide on list rendering](https://vuejs.org/guide/essentials/list.html)

- **v-for** directive: used to render list of elements
- `todo` in example: local variable within `v-for`, representing current element

```vue title="v-for Syntax"
<ul>
  <li v-for="todo in todos" :key="todo.id">
    {{ todo.text }}
  </li>
</ul>
```

list can be updated by
- mutating methods on source array
- replacing array with new array

```vue title="List Rendering Example" fold
<script setup>
import { ref } from 'vue'

// give each todo a unique id
let id = 0

const newTodo = ref('')
const todos = ref([
  { id: id++, text: 'Learn HTML' },
  { id: id++, text: 'Learn JavaScript' },
  { id: id++, text: 'Learn Vue' }
])

function addTodo() {
  // ...
  todos.value.push({id: id++, text: newTodo.value});
  newTodo.value = ''
}

function removeTodo(todo) {
  // ...
  todos.value = todos.value.filter((t) => t != todo);
}
</script>

<template>
  <form @submit.prevent="addTodo">
    <input v-model="newTodo" required placeholder="new todo">
    <button>Add Todo</button>
  </form>
  <ul>
    <li v-for="todo in todos" :key="todo.id">
      {{ todo.text }}
      <button @click="removeTodo(todo)">X</button>
    </li>
  </ul>
</template>
```

### Computed Property

- `computed()`: allows for refs to compute their `.value`s based on other reactive data sources
- tracks dependencies, caches results, automatically updates

```vue title="computed() Syntax"
<script setup>
import { computed } from 'vue'

let id = 0

const hideCompleted = ref(false)
const todos = ref([
  { id: id++, text: 'Learn HTML', done: true },
  { id: id++, text: 'Learn JavaScript', done: true },
  { id: id++, text: 'Learn Vue', done: false }
])

const filteredTodos = computed(() => todos.value.filter(
	(t) => !(hideCompleted.value && t.done)
))
</script>
```

### Lifecycle and Template Refs

- motivation: manually working with the DOM
- **template ref**: reference to element in template, accessed via ref with matching name
	- only accessible after **mounting** (-> `onMounted()` function)
- **lifecycle hook**: for registering a callback to be called during component's lifecycle -> [lifecycle diagram](https://vuejs.org/guide/essentials/lifecycle.html#lifecycle-diagram)

```vue title="Manual DOM example"
<script setup>
import { onMounted, ref } from 'vue'

const pElementRef = ref(null)

onMounted(() => {
  pElementRef.value.textContent = "Hello again";
})

</script>

<template>
  <p ref="pElementRef">Hello</p>
</template>
```

### Watchers
-> [guide on watchers](https://vuejs.org/guide/essentials/watchers.html)

- `watch()`: for reactive side effects, aka callbacks on value changes
	- works on refs and other data sources

```vue title="watch() Syntax"
<script setup>
import { ref, watch } from 'vue'

const count = ref(0)

watch(count, (newCount) => {
  // yes, console.log() is a side effect
  console.log(`new count is: ${newCount}`)
})
</script>
```

```vue title="watch() Example" fold
<script setup>
import { ref, watch } from 'vue'

const todoId = ref(1)
const todoData = ref(null)

async function fetchData() {
  todoData.value = null
  const res = await fetch(
    `https://jsonplaceholder.typicode.com/todos/${todoId.value}`
  )
  todoData.value = await res.json()
}

fetchData()

watch(todoId, fetchData)
</script>

<template>
  <p>Todo id: {{ todoId }}</p>
  <button @click="todoId++" :disabled="!todoData">Fetch next todo</button>
  <p v-if="!todoData">Loading...</p>
  <pre v-else>{{ todoData }}</pre>
</template>
```

### Components

- can be hierarchical, i.e. parent components can import and use child components

```vue title="Child Component Example"
<script setup>
import ChildComp from './ChildComp.vue'

</script>

<template>
  <!-- render child component -->
  <ChildComp />
</template>
```

### Props

- way for child component to accept input from parent

```vue title="Props in Child"
<script setup>
// compile-time macro, no import needed
const props = defineProps({
  msg: String
})
</script>
```

```vue title="Props via v-bind in Parent"
<ChildComp :msg="greeting" />
```

### Emits

- way for child component to emit events to parent

```vue title="Emits in Child"
<script setup>
// declare emitted events
const emit = defineEmits(['response'])

// emit with argument
emit('response', 'hello from child')
</script>
```

```vue title="Emits via v-on in Parent"
<ChildComp @response="(msg) => childMsg = msg" />
```

### Slots

- for parent to pass down template fragments to child

```vue title="Slot in Child"
<template>
  <slot>Fallback content</slot>
</template>
```

```vue title="Slot in Parent"
<script setup>
import { ref } from 'vue'
import ChildComp from './ChildComp.vue'

const msg = ref('from parent')
</script>

<template>
  <ChildComp>This is some slot content!</ChildComp>
</template>
```
