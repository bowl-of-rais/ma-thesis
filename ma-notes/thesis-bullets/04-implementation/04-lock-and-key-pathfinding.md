based on
- [[03-lock-key-pathfinding]]

## Pathfinding with and Analysis of Locks and Keys

requirements/context:
- multiple keys possible per node
- multiple locks possible per node
- pathfinding and reachability analysis

- #future_work : difficulty estimation #citation-needed , recommendations for lock/key types [@dormansCyclicGeneration2017], LLM-based consistency check with descriptions

### Basic Dijkstra with Locks and Keys

>[!goal] all locks assigned to edges in the path have to be unlocked by key(s) collected up to the edge in question

- inventory: track keys collected along path to determine whether encountered edges can be unlocked
	- inventory similar to [@aversaPathPlanningInventoryDriven2015]
	- modeled via `PxKeySet` -> formally: mapping of key defs to counts
- basic form: inventory associated with a node reflects keys collected along shortest path to this node and keys made available in this node -> later extended (consumable keys)

#### Unlocking Function

- `canUnlock()`: given (multi-)sets of locks and keys, determine whether locks can be unlocked
	- added complexity due to an edge potentially having multiple locks, and each locks potentially being unlocked by multiple keys
	- exponential blowup, but no optimization so far as average case is expected to be less complex #citation-needed 

given set of keys in inventory $K$ and locks on edge $L$:

```pseudo title="Unlocking function"
canUnlock(K, L):
	if L = ∅
		return TRUE
	
	unlockingKeysets = required(l1) ⨉ ... ⨉ required(ln)
	
	if ∃ U ∈ unlockingKeysets where ∀ u ∈ U. u ∈ K:
		return TRUE
	else
		return FALSE
```

##### Example

![[can-unlock-without-consume.canvas]]

- $I = {X, Y}$ -> false
- $I = X, Y, Z$ -> true

#### Full Algorithm

![[basic-lock-key-pathfinding.canvas|800]]

#### Example Iteration

- TODO add small example of iteration

### Special Locks/Keys

#### Fixed Keys

>[!goal] fixed keys can only unlock locks on outgoing edges of the node they are assigned to

**implementation**:
- do not add keys to inventory of neighbors

- TODO add example

#### Soft Gates

>[!goal] soft gates *can* be passed without the corresponding key, but this should be indicated in the path highlighting

**implementation**:
- during pathfinding, ignore soft-gate locks
- after path has been found, re-trace it to determine whether keys are available or not

- TODO add example from pixe

#### Consumable Keys and Soft-Lock Detection

>[!goal] inventory should reflect usage of single-use keys

- variants of inventory -> idea of 'parallel universes'
	- nodes exist in different realities if they have different inventories
	- assign each node a set of possible keysets

**implementation**:
- maintain set of `PxKeySets` per node
- in `canUnlock`, consider multiplicity of consumable keys
- for updating inventory of neighbor nodes: remove consumed keys from inventory
	- if there are multiple possible constellations, add multiple keysets

##### Pathfinding with Consumable Keys

###### Extending Unlocking Check

given multiset of keys in inventory $K$ and locks on edge $L$:

```pseudo title="Unlocking function"
canUnlock(K, L):
	if L = ∅
		return TRUE
	
	unlockingKeysets = required(l1) ⨉ ... ⨉ required(ln)
	
	if ∃ U ∈ unlockingKeysets where U ⊆ K:
		return TRUE
	else
		return FALSE
```

- note: subset of multiset

![[can-unlock-with-consume.canvas]]

- now: $I = {X, Z}$ -> false

###### Removing Consumable Keys from Inventory

given inventory $I$ containing multisets of keys $K$ and locks on edge $L$:

```pseudo title="Removing consumed keys"
canUnlock(I, L):
	if L = ∅
		return TRUE
		
	consumableRequirements = locks with at least one consumable key unlocking
	
	unlockingKeysets = required(l1) ⨉ ... ⨉ required(ln)
	
	updatedInventory = {}
	for K_i ∈ I:
		if ∃ U ∈ unlockingKeysets with K_i ⊆ U:
			updatedInventory.push(K_i - { key∈U. consumable(key)})
			
	return updatedIinventory
```

![[remove-consumed.canvas]]

- $I = \{X, X, Z\}$ -> $\{Z\}$

###### Example

- TODO example in pixe for consumable keys


##### Soft-Locks

[@mawhorterSoftlockDetectionSuper2021]:
>it is possible to reach the goal state from every reachable state

- here: not nodes, but *states in which nodes are visited*

![[soft-lock-example.canvas|200]]

**implementation**:
- potential soft-lock state: node unlockable with some, but not all keysets
- when removing consumed keys: remove empty keysets entirely. then, compare inventory length before and after consumption

###### Example

- TODO example in pixe for consumable keys

### Bidirectional Edges and Backtracking

>[!goal] allow for longer/cyclic paths needed to collect keys

- another idea of parallel universes
- TODO add citation from julians paper?

**implementation**:
- alternative used here: nodes are re-added to queue iff they have a different inventory assigned to them than in previous encounters -> only duplicate nodes as needed
	- for each node, maintain inventories it has been visited with
		- only re-visit with a different inventory
	- add limiting constant for revisits
	- also maintain unlocked edges

![[backtracking.canvas]]

- critical path: $A - B - A - C$

![[lock-key-pathfinding-backtracking.canvas|800]]

#### Example

- TODO example screenshot from pixe

### Full Algorithm

- TODO make diagram of full algorithm?

### Options/Settings

- TODO describe pathfinding options

### Testing

- TODO describe 

