based on
- [[03-lock-key-pathfinding]]

## Pathfinding with Locks and Keys

requirements/context:
- multiple keys possible per node
- multiple locks possible per node

### Basic Dijkstra with Locks and Keys

>[!goal] all locks assigned to edges in the path have to be unlocked by key(s) collected up to the edge in question

- inventory: track keys collected along path to determine whether encountered edges can be unlocked
	- inventory similar to [@aversaPathPlanningInventoryDriven2015]
	- modeled via `PxKeySet` -> formally: mapping of key defs to counts
- basic form: inventory associated with a node reflects keys collected along shortest path to this node and keys made available in this node -> later extended (consumable keys)
- `canUnlock()`: given (multi-)sets of locks and keys, determine whether locks can be unlocked
	- added complexity due to an edge potentially having multiple locks, and each locks potentially being unlocked by multiple keys
	- exponential blowup, but no optimization so far as average case is expected to be less complex #citation-needed 

given (multi-)set of keys in inventory $K$ and locks on edge $L$:

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


![[basic-lock-key-pathfinding.canvas|800]]

- TODO add small example of iteration

### Considering Special Keys/Locks

#### Fixed Keys

>[!goal] fixed keys can only unlock locks on outgoing edges of the node they are assigned to

**implementation**:
- do not add keys to inventory

- TODO add example

#### Soft Gates

>[!goal] soft gates *can* be passed without the corresponding key, but this should be indicated in the path highlighting

**implementation**:
- TODO

- TODO add example

#### Consumable Keys (Soft Locks)

>[!goal] inventory should reflect usage of single-use keys

- variants of inventory -> idea of 'parallel universes'
	- nodes exist in different realities if they have different inventories
	- assign each node a set of possible keysets

- TODO example of how different keys could be used

**implementation**:
- TODO

### Bidirectional Edges and Backtracking

>[!goal] allow for longer/cyclic paths needed to collect keys

- another idea of parallel universes
- TODO add citation from julians paper?
- alternative used here: nodes can be re-added to queue iff they have a different inventory assigned to them than in previous encounters

- TODO add basic backtracking example

### Full Algorithm

- TODO make diagram of full algorithm
