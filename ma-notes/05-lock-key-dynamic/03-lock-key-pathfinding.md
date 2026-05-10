---
start:
end:
task-status:
task-category: implementation
tags:
  - "#implementation"
  - "#research"
milestone: 26-03
---

- [/] integrate locks/keys into pathfinding 🛫 2026-04-11
- [ ] write about pathfinding with locks/keys

## Usage

- calculate path based on selection -> consider locks and keys

## Additional Considerations Based On Attributes

- consumable keys can only be used once
- fixed keys stay where they are
	- can also open locks further away? -> #future_work 
- collapsible locks cannot be passed again
- temporarily unlocked locks need to be unlocked again

- soft gates: indicate nodes in path with special icons?

## Architecture/Implementation

- pathfinding is based on VueFlow nodes/edges

- [x] load locks and keys as data ✅ 2026-04-11

- [x] integrate into pathfinding -> dijkstra with inventory tracking ✅ 2026-04-12
- [/] combine with regular pathfinding: find path with/without locks
	- [x] if path found: regular highlighting, prefer locked path ✅ 2026-04-12
	- [x] highlight locks that cannot be unlocked ✅ 2026-04-13
		- [ ] restrict to ones that block the path -> 2nd pathfinding?
	- [ ] if path would be found only without locks: special highlighting?
		- calculate in one go, if possible
		- error highlight

- [x] consider lock/key types ✅ 2026-04-27
	- [x] remove consumable keys from inventory after usage ✅ 2026-04-27
		- [x] inventory and `unlockingKeySets` need to be maps (to keep track of counts)? ✅ 2026-04-27
		- [-] `{js}canUnlock()` returns `{js}consumed: string[]`, which are then removed from inventory
		- [x] separate check when updating queue: what keys will be consumed when choosing specific edge? ✅ 2026-04-27
			- heuristic: use key combination that consumes the smallest number of consumable keys -> not fully accurate as of now, may lead to soft-locks
			- #future_work : improve heuristic, e.g. by adding rarity (common/rare/...)
	- [x] soft locks: highlight subsequent path (warn - yellow) ⛔ save-path-edges ✅ 2026-04-20
		- separate treatment for soft gates?
	- [x] fixed keys are removed from inventory after node is processed ✅ 2026-04-12
	- [-] #future_work remote fixed keys (e.g. lever that opens door in another room)

- [x] save edges in found path 🆔 save-path-edges 🛫 2026-04-20 ✅ 2026-04-20

- [ ] identify path via edges only?
	- edges contain `sourceNode`/`targetNode`
	- find out whether these are copies or by reference
		- [s] check if styling can be applied ✅ 2026-04-27

- [x] fix add key to node ✅ 2026-04-28
- [x] fix adding lock definition ✅ 2026-04-28
	- fixed `soft_gate` name
	- `unlocked_by` is actually required -> reflect in UI
- [ ] fix lock visualization directly after adding lock ⏳ 2026-04-29 
- [x] more expressive failure: info instead of error toast, but highlight start/end node in red? ✅ 2026-04-28
- [x] add settings for path calculation 🛫 2026-04-29 ✅ 2026-05-10
	- [x] make modal ✅ 2026-04-29
	- [x] pass values to `usePxChartPathCalculation` ✅ 2026-04-29
	- [x] ignore locks/keys ✅ 2026-04-29
	- [x] ignore key consumption ✅ 2026-05-04
	- [x] show soft locks ✅ 2026-05-04
	- [-] when ignoring locks: hide lock/key visualizations in statechart
	- [x] persist settings ✅ 2026-05-10
		- [x] add to backend data model -> migrate ✅ 2026-05-04
		- [x] add to frontend API/data model ✅ 2026-05-04
		- [x] when loading chart: check if they exist. if yes: load, if no: create with default values ✅ 2026-05-10
		- [x] when modifying settings: persist ✅ 2026-05-10
		- [x] make user-specific ✅ 2026-05-10

overall algorithm:

- find shortest unlocked path
	- inventory: holds keys, updates based on different paths taken
		- inventory should be per node!
	- record used edges
- after path has been found:
	- identify soft-gated tail

- [ ] refine/modularize/refactor pathfinding code
- [ ] create diagram/flowchart for algorithm

## Testing

- fixed keys cannot be used to unlock subsequent locks
- collapsible locks are only passed once
	- circular statechart with key collection loop?

## Algorithms

background:
- [[A*]]
- [[JPS]]

### Inventory-Based Path-Finding

[@aversaPathPlanningInventoryDriven2015]:
>Path planning in the context of agents who carry objects - an "inventory" - that can influence the navigation process.

- [r] shortest path given
- set of nodes $M = \{m_{11}, m_{12}, \dots\}$
- set of blocked nodes $O \subseteq M$
- adjacency relation among nodes $adj : M \mapsto 2^M$
- items $\mathcal{I}$
- locations of items
- requirements for traversing a node
- start node $S$ and destination $G$

>[!caution] beware of exponential blowup


## Archive

```js
      const [unlockedOuts, lockedOuts] = getOutgoers(node.id, nodes.value, edges.value)
        .reduce((acc, node) => unlockedOutNodeIds.includes(node.id)
          ? (acc[0].push(node), acc)
          : (acc[1].push(node), acc), 
          [[], []] as [Node[], Node[]]);
          
          
          
        
    /*
    const requiredKeys : Map<string, number> = new Map()
    locks.forEach((lock) => {
        const def = pxLockDefinitions.value.find(def => def.id === lock.definition)!
        def.unlocked_by.forEach((keyDef) => {
            const count = requiredKeys.get(keyDef)
            if (!count) {
                requiredKeys.set(keyDef, 1)
            } else {
                requiredKeys.set(keyDef, count + 1)
            }
        })
    })
        */

```

```js title="canUnlock()"
function canUnlock(keys: PxKey[], locks: PxLock[]) {
    console.log(`starting unlock check. ${keys.length} keys, ${locks.length} locks`)
    if (!locks.length) {
        //console.log(`unlock possible: ${true}`)
        return true
    }

    // for set of locks, determine all sets of keys that can unlock them
    const requiredKeysPerLock : string[][] = locks
        .map(lock => pxLockDefinitions.value.find(def => def.id === lock.definition)!)
        .map(def => def.unlocked_by)

    console.log(`requiredKeysPerLock: ${requiredKeysPerLock.map(keyset => keyset.toString()).join(' --- ')}`)

    const unlockingKeySets : string[][] = cartesian(requiredKeysPerLock)
    
    console.log(`unlockingKeySets: ${unlockingKeySets.map(keyset => keyset.toString()).join(' --- ')}`)
    console.log(`typeof unlockingKeySets[0]: ${typeof unlockingKeySets[0]}`)
    console.log(`available keys (defs): ${keys.map(k => k.definition).toString()}`)

    // check if any unlocking key set is a subset of the available keys
    const availableKeyDefs = keys.map(k => k.definition)
    const unlock = unlockingKeySets.some(set => set.every(key => availableKeyDefs.includes(key)))
    
    console.log(`unlock possible: ${unlock}`)

    return unlock
  }
```


```ts title="removeConsumed() heuristic"

  // removes consumed keys heuristically: chooses unlocking key combination with smallest number of consumable keys
  function _consumedKeys(keysInInventory: PxKeySet, locks: PxLock[]): PxKeySet {
    if (!locks.length) return {}

    const consumableRequirements = locks
      .map((lock) => pxLockDefinitionsById.value[lock.definition]!.unlocked_by)
      .filter(
        (requiredKeys) =>
          requiredKeys.filter((keyDef) => pxKeyDefinitionsById.value[keyDef]!.consumable).length,
      )

    if (!consumableRequirements.length) return {}

    const unlockingKeySets: PxKeySet[] = cartesian(consumableRequirements).map((keys) =>
      getKeySetFromDefArray(keys),
    )
    console.log(`unlockingKeySets: ${JSON.stringify(unlockingKeySets)}`)
    console.log(`keysInInventory: ${JSON.stringify(keysInInventory)}`)

    const unlockedKeySets: PxKeySet[] = unlockingKeySets
      .filter((unlocking) =>
        Object.entries(unlocking).every(
          ([keyDefId, count]) =>
            // locks can be unlocked if keys are present and, if consumable, present at least as many times as required
            keysInInventory[keyDefId] &&
            (!pxKeyDefinitionsById.value[keyDefId]!.consumable ||
              keysInInventory[keyDefId] >= count),
        ),
      )
      .sort((ks1, ks2) => countConsumable(ks1) - countConsumable(ks2)) // heuristic to determine which keys to consume

    if (!unlockedKeySets.length) return {}

    const bestKeySet = unlockedKeySets[0]!

    return Object.fromEntries(
      Object.entries(bestKeySet).filter(
        ([keyDef, _count]) => pxKeyDefinitionsById.value[keyDef]!.consumable,
      ),
    )
  }
```
