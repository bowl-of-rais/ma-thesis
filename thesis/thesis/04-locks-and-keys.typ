#import "../utils.typ": todo
#import "../bib.typ": load-bib

#import "@preview/lovelace:0.3.1": *

#show raw.where(block: true): it => block(
  fill: rgb("#eeeeee"),
  //fill: rgb("#c6e2f7"),
  inset: 8pt,
  radius: 4pt,
  width: 100%,
  text(it)
)

= Locks and Keys <id>

requirements/context:
- multiple keys possible per node
- multiple locks possible per node
- pathfinding and reachability analysis

== Creating and Visualizing Locks and Keys


== Pathfinding with Locks and Keys

=== Basic Dijkstra with Locks and Keys

- goal: all locks assigned to edges in the path have to be unlocked by key(s) collected up to the edge in question

- inventory: track keys collected along path to determine whether encountered edges can be unlocked
	- inventory similar to #cite(<aversaPathPlanningInventoryDriven2015>)
	- modeled via `PxKeySet` -> formally: mapping of key defs to counts
- basic form: inventory associated with a node reflects keys collected along shortest path to this node and keys made available in this node -> later extended (consumable keys)

==== Unlocking Function

- `canUnlock()`: given (multi-)sets of locks and keys, determine whether locks can be unlocked
	- added complexity due to an edge potentially having multiple locks, and each locks potentially being unlocked by multiple keys
	- exponential blowup, but no optimization so far as average case is expected to be less complex // TODO citation

given set of keys in inventory $K$ and locks on edge $L$:

```
canUnlock(K, L):
	if L = ∅
		return TRUE
	
	unlockingKeysets = required(l1) × ... × required(ln)
	
	if ∃ U ∈ unlockingKeysets where ∀ u ∈ U. u ∈ K:
		return TRUE
	else
		return FALSE
```


#pseudocode-list[
+ canUnlock(K, L):
	+ if $L = emptyset$
		+ return TRUE
	
	+ unlockingKeysets = required(l1) ⨉ ... ⨉ required(ln)
	
	+ if $exists U in "unlockingKeysets" "where" forall u in U. u in K$:
		+ return TRUE
	+ else
		+ return FALSE
]

==== Example

![[can-unlock-without-consume.canvas]]

- $I = {X, Y}$ -> false
- $I = X, Y, Z$ -> true

==== Full Algorithm

![[basic-lock-key-pathfinding.canvas|800]]

==== Example Iteration

- TODO add small example of iteration

=== Fixed Keys

- goal: fixed keys can only unlock locks on outgoing edges of the node they are assigned to

*implementation*:
- do not add keys to inventory of neighbors

- #todo("add example")

=== Soft Gates

- goal: soft gates *can* be passed without the corresponding key, but this should be indicated in the path highlighting

*implementation*:
- during pathfinding, ignore soft-gate locks
- after path has been found, re-trace it to determine whether keys are available or not

- #todo("add example from pixe")

=== Consumable Keys and Soft-Lock Detection

- goal: inventory should reflect usage of single-use keys

- variants of inventory -> idea of 'parallel universes'
	- nodes exist in different realities if they have different inventories
	- assign each node a set of possible keysets

*implementation*:
- maintain set of `PxKeySets` per node
- in `canUnlock`, consider multiplicity of consumable keys
- for updating inventory of neighbor nodes: remove consumed keys from inventory
	- if there are multiple possible constellations, add multiple keysets

==== Pathfinding with Consumable Keys

===== Extending Unlocking Check

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

===== Removing Consumable Keys from Inventory

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

#pad(
  rest: 10pt,
  figure(
    image("assets/04/remove-consumed.drawio.png", width: 50%),
    caption: "Calculation of unlocking keysets for key consumption",
    gap: 2em
  )
)

- $I = \{X, X, Z\}$ -> $\{Z\}$

===== Example

- #todo("example in pixe for consumable keys")


==== Soft-Locks

[@mawhorterSoftlockDetectionSuper2021]:
>it is possible to reach the goal state from every reachable state

- here: not nodes, but *states in which nodes are visited*

![[soft-lock-example.canvas|200]]

*implementation*:
- potential soft-lock state: node unlockable with some, but not all keysets
- when removing consumed keys: remove empty keysets entirely. then, compare inventory length before and after consumption

===== Example

- #todo("example in pixe for consumable keys")

== Bidirectional Edges and Backtracking

- goal: allow for longer/cyclic paths needed to collect keys

- another idea of parallel universes
- #todo("add citation from julians paper?")

*implementation*:
- alternative used here: nodes are re-added to queue iff they have a different inventory assigned to them than in previous encounters -> only duplicate nodes as needed
	- for each node, maintain inventories it has been visited with
		- only re-visit with a different inventory
	- add limiting constant for revisits
	- also maintain unlocked edges

![[backtracking.canvas]]

- critical path: $A - B - A - C$

![[lock-key-pathfinding-backtracking.canvas|800]]

=== Example

- #todo("example screenshot from pixe")

=== Full Algorithm

- #todo("make diagram of full algorithm?")

== Options/Settings

- #todo("describe pathfinding options")

== Testing

- #todo("describe")

== Limitations and Future Workflow

- difficulty estimation // TODO citation-needed
- recommendations for lock/key types #cite(<dormansCyclicGeneration2017>)
- LLM-based consistency check with descriptions


#load-bib()