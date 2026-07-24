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

= Locks and Keys <impl_lk>

requirements/context:
- multiple keys possible per node
- multiple locks possible per node
- pathfinding and reachability analysis

== Definition

#cite(<ashmoreQuestGeneratedWorld2007>):
"The puzzle is finding out what is an obstacle, what and where is a key to overcome it, and finally using the key to master the challenge."

- in statechart: conditional transition

#cite(<ashmoreQuestGeneratedWorld2007>):
"Obstacles may not be passed until the player obtains some token (such as an item or skill)""

- keys as abstract tokens, different kinds to distinguish: keys/locks should have some category to specify this

#cite(<dormansCyclicGeneration2017>):
"Some locks are barriers that might be navigated without a key, but this crossing the barrier might be uncertain or impose a certain risk."

#cite(<ashmoreQuestGeneratedWorld2007>) present lock/key puzzles as a type of quest
- future work: model/analyze other types of quests (explicit, specific tasks, mission objectives)

== Taxonomy

#cite(<dormansCyclicGeneration2017>):
"When you unlock a door, that door might remain unlocked forever (permanent), for a short period of time (temporary), or until it is relocked (reversible). Sometimes, a lock collapses after use, allowing the player only to pass once."

-> locks: *permanent, temporary, reversible, collapsible*

#cite(<dormansCyclicGeneration2017>):
"Single-purpose keys can only be used to open a lock, and for nothing else, while multipurpose keys can also be used in different ways."

-> keys: *single-purpose or multi-purpose*
- attribute `type` on keys: `ability`, `item`

#cite(<dormansCyclicGeneration2017>):
"Particular keys are the only thing that unlocks a particular lock, whereas several nonparticular keys might unlock a single lock."

-> keys: *particular or non-particular*
- probably easier to understand when this is a property of a lock, i.e. key requirement

#cite(<dormansCyclicGeneration2017>):
"Keys that are destroyed somehow in the process of unlocking a door are consumable, while keys that are not are persistent."

-> keys: *consumable or persistent*

#cite(<dormansCyclicGeneration2017>):
"Levers and switches are the best example of keys that are fixed in place (and typically single purpose and particular as well)."

-> keys: *fixed or not*

#cite(<dormansCyclicGeneration2017>):
"Certain locks allow you to cross only in one direction (valves), while others can only be opened from one direction but traversed in two directions after they are opened (asymmetrical). \[...\] Valves do not always require a key.""

-> locks: *valve, asymmetrical*
- modeled via bidirectional edges with locks vs two uni-directional edges, one with lock and one without

=== Not Modeled Currently

#cite(<dormansCyclicGeneration2017>):
"A safe lock is guaranteed to have a solution, while an unsafe lock is not."

=== Data Model Overview

#todo("add diagram of data model")

== Creating and Visualizing Locks and Keys

#cite(<brownHowMyBoss2026>): high-level visual representation. only focuses on locks and keys and where they are in relation to each other

to integrate into player experience chart: assign keys to nodes and locks to edges (to maintain clear structure)

=== Modeling Keys

- similar to PxComponents: definitions separate from instantiations in nodes
- multiple instances of same definitions possible per node

#todo("add screenshots of key definitions and assignments in UI + explain options")

=== Modeling Locks

- same split between definitions and instantiations
- instantiations on edges: additional UI/modal

#todo("add screenshots of lock definitions and assignments in UI + explain options")

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
	- exponential blowup, but no optimization so far as average case is expected to be less complex #todo("citation")

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

/*
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
*/

==== Example

#pad(
  rest: 10pt,
  figure(
    image("assets/04/can-unlock-without-consume.drawio.png", width: 50%),
    caption: "Calculation of unlocking keysets",
    gap: 2em
  )
)

- $I = {X, Y}$ -> false
- $I = X, Y, Z$ -> true

==== Full Algorithm

#pad(
  rest: 10pt,
  figure(
    image("assets/04/lock-key-pathfinding-basic.drawio.png", width: 50%),
    caption: "Pathfinding Algorithm with Locks & Keys (Basic)",
    gap: 2em
  )
)

==== Example Iteration

- #todo("add small example of iteration")

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

*Extending Unlocking Check*

given multiset of keys in inventory $K$ and locks on edge $L$:

```
canUnlock(K, L):
	if L = ∅
		return TRUE
	unlockingKeysets = required(l1) × ... × required(ln)
	if ∃ U ∈ unlockingKeysets where U ⊆ K:
		return TRUE
	else
		return FALSE
```

- note: subset of multiset

#pad(
  rest: 10pt,
  figure(
    image("assets/04/can-unlock-with-consume.drawio.png", width: 50%),
    caption: "Calculation of unlocking keysets as multisets",
    gap: 2em
  )
)


- now: $I = {X, Z}$ -> false

*Removing Consumable Keys from Inventory*

given inventory $I$ containing multisets of keys $K$ and locks on edge $L$:

```
canUnlock(I, L):
	if L = ∅
		return TRUE
	consumableRequirements = locks with at least one consumable key unlocking	
	unlockingKeysets = required(l1) × ... × required(ln)
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

- #todo("example in pixe for consumable keys")


==== Soft-Locks

definition:
"it is possible to reach the goal state from every reachable state"
#cite(<mawhorterSoftlockDetectionSuper2021>):

- here: not nodes, but _states_ in which nodes are visited

#pad(
  rest: 10pt,
  figure(
    image("assets/04/soft-lock-example.drawio.png", width: 80%),
    caption: "Example: Soft-lock",
    gap: 2em
  )
)

*implementation*:
- potential soft-lock state: node unlockable with some, but not all keysets
- when removing consumed keys: remove empty keysets entirely. then, compare inventory length before and after consumption

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

#pad(
  rest: 10pt,
  figure(
    image("assets/04/backtracking.drawio.png", width: 80%),
    caption: "Example: Backtracking",
    gap: 2em
  )
)

- critical path: $A - B - A - C$

#pad(
  rest: 10pt,
  figure(
    image("assets/04/lock-key-pathfinding-backtracking.drawio.png", width: 50%),
    caption: "Pathfinding Algorithm with Locks & Keys (Complete)",
    gap: 2em
  )
)

=== Example

- #todo("example screenshot from pixe")

=== Full Algorithm

- #todo("make diagram of full algorithm?")

== Options/Settings

- #todo("describe pathfinding options")

== Code Architexture

#todo("add diagram for code architecture?")

== Testing

- #todo("describe")

== Limitations and Future Work

- fixed keys for non-adjacent locks
- in pathfinding: temporary, reversible, collapsible locks
- difficulty estimation #todo("add citation")
- recommendations for lock/key types #cite(<dormansCyclicGeneration2017>)
- LLM-based consistency check with descriptions


#load-bib()