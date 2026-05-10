---
start: 2026-04-29
end:
tags:
  - implementation
  - bonus
milestone: 26-05
---

## Input Validation

- [x] add validation on input forms ✅ 2026-04-29
	- [x] pxlock definition -> `pxlockkeydefinitions.vue`, `pxlockdefinitions` ✅ 2026-04-29
		- name not empty, unlocked_by not empty
	- [x] pxkey definition -> `pxlockkeydefinitions.vue`, `pxkeydefinitions` ✅ 2026-04-29
		- name not empty, type not empty
	- [x] pxkey -> `PxKeyCreationForm.vue` ✅ 2026-04-29
		- definition selected, count > 0
	- [x] pxlock -> `PxLockEditForm.vue` ✅ 2026-04-29
		- count >= 0
	- [x] component definitions -> `pxcomponentdefinitions/index.vue` ✅ 2026-04-29
		- non-empty name, type not none
	- [x] components -> already has some. `PxComponentCreationForm` ✅ 2026-04-29
		- non-empty definition selection, non-empty string/number values
		- refactor formfields a bit, give each value type a different (internal) name so that validation resets when changing types
- [x] check that all required fields are marked as such and validated ✅ 2026-05-04
	- checked: PxKeyCreationForm, 
	- not validated, not necessary: PxKeyDefinitionCardDetailed, PxLockDefinitionCardDetailed, PxLockEditForm, 
	- 
- [x] potentially add select fields: do they need validation? ✅ 2026-05-04
	- definitely yes, when default is undefined -> pxkeydefinition, 
	- otherwise, idk? -> pxkey, 
	- to add: unlocked_by in PxLockDefinitionCardDetailed -> different architecture (within node)
- [ ] potentially prevent duplicate names? of nodes, keys, locks, ...
- [ ] add functionality to change key count in nodes
- [ ] fix key types not visible/editable in PxKeyDefinitionCardDetailed
- [ ] minimal preview chip for charts
- [ ] rename preview cards (keys, components) to chips
- [ ] align create node ui with others?
- [ ] refactor pxlockkeydefinitions to consist of two pages
	- [ ] make pages available horizontal and vertical

- [?] why does `PxValueTypes` include none?
	- for the PxComponentDefinition, the only value types included in the selection were string, number, boolean
	- so a definition of type 'none' does not seem to be intended
	- I set the default value to undefined and added validation (value must be truthy)

screenshot from validation in PxComponent:

![[Pasted image 20260429205941.png]]

-> probably native HTML validation
-> better to unify for consistent UI
- see if UForm validation takes precedence

### Implementation Pattern

- also need to add `name` field to FormFields

example from [Nuxt docs](https://ui.nuxt.com/docs/components/form)

```ts
import type { FormError, FormSubmitEvent } from '@nuxt/ui'

const state = reactive({
  email: undefined,
  password: undefined
})

type Schema = typeof state

function validate(state: Partial<Schema>): FormError[] {
  const errors = []
  if (!state.email) errors.push({ name: 'email', message: 'Required' })
  if (!state.password) errors.push({ name: 'password', message: 'Required' })
  return errors
}
```

### Existing implementation: `PxComponents`

- unsure how it works lmfao

## FormField Widths in Modals

![[Pasted image 20260429204014.png]]

 - [x] make form fields span the whole modal ✅ 2026-05-04

also here:

![[Pasted image 20260429205848.png]]

## Item Width in SelectMenu Components

[SelectMenu docs](https://ui.nuxt.com/docs/components/select-menu#with-full-content-width):
>You can expand the content to the full width of its items by adding the `min-w-fit` class on the `ui.content` slot.

- [ ] adjust item width in selectmenu compnents

## Consistent Display Names in SelectMenus

e.g. key types:

![[Pasted image 20260429210152.png]]

should be capitalized
-> figure out where this is best defined, maybe there is a way to add this centrally

- [ ] use consistent display names in SelectMenus

## Improve Multi-Select

![[Pasted image 20260429210536.png]]

- selection grows

- [ ] limit width of selected values in SelectMenu

## Make Sure SelectMenu Is Used When Appropriate

- selectMenu offers search functionality, while select does not
- this should be used for selections of e.g. nodes, where there may be a lot of

- [x] review USelect vs USelectMenu usage, enable search where useful ✅ 2026-05-04

## Check Emit Types

- [ ] prevent ts error regarding emit payload types

## Improve Edge Label Background

- [x] different label background for locks (dark mode)  -> transparent ✅ 2026-05-04

## Add Cross-Links Wherever Possible

- [ ] links to keys in unlockedBy



### WIP

```ts
  function getPathStyle(color: string) {
    return {
      border: `3px solid ${color}`,
      borderRadius: '10px',
      boxShadow: `0 0 10px ${color}`,
    }
  }

  async function updateNodeStyling() {
    // set style of nodes in calculated path
    for (const node of nodes.value) {
      if (!path.value.length && selectedNodes.value.includes(node.id)) {
        // use error color for selected nodes when no path connects them
        node.style = getPathStyle('var(--ui-error)')
      } else if (settings.value.show_soft_locks && softLocked.value.includes(node.id)) {
        // use info color for nodes with potential soft locks
        node.style = getPathStyle('var(--ui-info)')
      } else if (gatedPath.value.nodes.includes(node)) {
        // use warn color for path parts behind a soft gate
        node.style = getPathStyle('var(--ui-warning)')
      } else if (path.value.includes(node.id)) {
        // use primary color for nodes in regular path
        node.style = getPathStyle('var(--ui-primary)')
      } else {
        node.style = undefined
      }
    }
  }
```
