#import "../utils.typ": todo
#import "../bib.typ": load-bib

#import "@preview/lovelace:0.3.1": *

/*
#show raw.where(block: true): it => block(
  fill: rgb("#eeeeee"),
  //fill: rgb("#c6e2f7"),
  inset: 8pt,
  radius: 4pt,
  width: 100%,
  text(it)
)
*/

#let pseudocode(content, caption) = {
set par(justify: false)
figure(
  block(
    fill: luma(250), 
    radius: 3pt,
    stroke: .6pt + luma(200),
    inset:	(x: 1em, y: 1em),
    width: 100%,
    clip: false,
  [#align(left)[#content]]),
  gap: 1em,
  caption: [#caption],
  supplement: "Pseudocode",
  kind: "code",
  outlined: true
)}

= Locks and Keys <impl-lk>

- novel functionality (not in PaceMaker)
- can be used both low-level (e.g. to model individual puzzles/dungeons) or high-level (e.g. to model storylines and their prerequisites) -> some range in use cases. possible high complexity in lock/key type puzzles #todo("add citation"), so analysis/verification/debugging functionality has potential for high impact.

== Requirements <lk-requirements>

- use @bg-lock-key-taxonomy as reference for requirements to the lock/key functionality in pix:e
- in statechart: conditional transition
- reflect concept of keys as abstract tokens, different kinds to distinguish: keys/locks should have some category to specify this

- locks: *permanent, temporary, reversible, collapsible*
    - attribute `unlockMode` on locks, can then be referred to in pathfinding logic
- keys: *single-purpose or multi-purpose*
    - attribute `type` on keys: `ability`, `item`
- keys: *particular or non-particular*
    - probably easier to understand when this is a property of a lock, i.e. key requirement
- keys: *consumable or persistent*
    - attribute `consumable` on keys, can then be referred to in pathfinding logic
- keys: *fixed or not*
    - attribute `fixed` on keys, can then be referred to in pathfinding logic
- locks: *valve, asymmetrical*
    - modeled via bidirectional edges with locks vs two uni-directional edges, one with lock and one without
- locks: *safe or unsafe*: not currently modeled

== Resulting Data Model <lk-data-model>

#figure(
  image("assets/04/lock-key-data-model.drawio.png"),
  caption: "Data model for locks and keys"
)

#todo("review multiplicities")

- lock definitions and key definitions are used to represent different types of locks and keys, including the variations/aspects described in @bg-lock-key-taxonomy.
- in particular, a lock definition can be assigned multiple key definitions that unlock it. the same key definition can also be assigned to multiple lock definitions as an unlocking key type. additionally, both lock and key definitions can be reused across assignments.
- each pair of lock definitions and edge/key definition and node may have at most one assignment. assignments record `count` to model multiplicity.

== Creation and Visualization of Locks and Keys <lk-creation-visualization>

#cite(<brownHowMyBoss2026>): high-level visual representation. only focuses on locks and keys and where they are in relation to each other

to integrate into player experience chart: assign keys to nodes and locks to edges (to maintain clear structure)

=== Defining Types of Locks and Keys

- for both locks and keys: definitions separate from instantiations in nodes, analogous to PxComponents -> same logic behind both concepts
- both defined on same page so users can e.g. refer to details about key definitions while creating lock definitions and vice versa. page can be seen in @lk-defs. layout: creation forms on the left (with help texts and indicators for necessary inputs), respective `ScrollArea`s for existing lock/key definitions next to it.

#figure(
  image("assets/04/lock-key-definitions-page.png"),
  caption: "Page 'Lock and Key Definitions'"
) <lk-defs>

=== Modeling Keys

- multiple instances of same definition possible per node as defined in data model
- icon button in node (see @node-with-keys) opens modal (see @key-creation-modal) where users can choose a key definition (from all definitions without an existing assignment) and respective count. both are technically required, count has default value 1.
- key assignments in nodes are represented by chips (count + definition name, see @node-with-keys), choice made due to compactness. chips have included button for deletion.

#grid(
  columns: 2,
  inset: 5pt,
  grid.cell([
    #figure(
      image("assets/04/add-key-modal.png"),
      caption: "Modal for creating a key assignment for a node"
    ) <key-creation-modal>
  ]),
  grid.cell([
    #figure(
      image("assets/04/node-with-key-assignment.png", width: 75%),
      caption: "Visual representation of two key assignments in a node"
    ) <node-with-keys>
  ])
)

- limitation: no editing of existing assignments. same as PxComponents, both would benefit from refactoring for easier editing.

=== Modeling Locks

- same as keys, multiple instances of same definition possible per edge, see data model.
- different from keys: edges are chart-specific and not represented in UI except for in the chart themselves. intention: make it clear that adding a lock to an edge is specific to that edge. vueflow framework does not offer built-in context menu for edges. possible future improvement: custom button implementation to simulate context menu (also for other actions like edge deletion). current workaround: buttons that are only visible if exactly one edge is selected. benefit: edge selection is easily detected.
- lock creation modal (see @edit-lock-modal): overview of all available lock definitions and instance counts on selected edge -> multiple and different kinds of locks can be edited/added in the same modal. key icon in each row shows unlocking key definitions.

#figure(
  image("assets/04/edit-lock-modal.png", width: 50%),
  caption: "Modal for creating/editing lock assignments for an edge"
) <edit-lock-modal>

== Pathfinding with Locks and Keys <lk-pathfinding>

=== Basic Dijkstra with Locks and Keys

- goal: all locks assigned to edges in the path have to be unlocked by key(s) collected up to the edge in question

- inventory: track keys collected along path to determine whether encountered edges can be unlocked
	- inventory similar to #cite(<aversaPathPlanningInventoryDriven2015>)
	- modeled via `PxKeySet` -> formally: mapping of key defs to counts
- basic form: inventory associated with a node reflects keys collected along shortest path to this node and keys made available in this node -> later extended (consumable keys, backtracking)

==== Unlocking Function

- `canUnlock()`: given (multi-)sets of locks and keys, determine whether locks can be unlocked
	- added complexity due to an edge potentially having multiple locks, and each locks potentially being unlocked by multiple keys
	- exponential blowup, but no optimization so far as average case is expected to be less complex #todo("citation?")

given set of keys in inventory $K$ and locks on edge $L$:

#pseudocode(
    [```
    canUnlock(K, L):
        if L = ∅
            return TRUE
        unlockingKeysets = required(l1) × ... × required(ln)
        if ∃ U ∈ unlockingKeysets where ∀ u ∈ U. u ∈ K:
            return TRUE
        else
            return FALSE
    ```],
    "Function checking whether a set of locks L can be unlocked by keys K"
)

==== Example

#todo("add image (graph)?")

Three locks assigned to one edge:
- lock $A$ which can be unlocked by keys of type $X$ or $Y$
- lock $B$ which can be unlocked by keys of type $X$
- lock $C$ which can be unlocked by keys of type $Z$

Leaving out consumability of keys: to unlock this edge, one could use the key sets ${X, Z}$ or ${X, Y, Z}$. If either is a subset of the available keys when encountering the edge, it can be unlocked.

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

#todo("add example in pix:e")

==== Full Algorithm

#pad(
  rest: 10pt,
  figure(
    image("assets/04/lock-key-pathfinding-basic.drawio.png", width: 50%),
    caption: "Main Loop of Pathfinding Algorithm with Locks & Keys (Basic)",
    gap: 2em
  )
)

==== Example Iteration

- #todo("add small example of iteration")

=== Fixed Keys

- goal: fixed keys can only be used within node they are assigned to
- limitation of current data model: no additional information for unlocking remote locks (would have to specify individual instances/assignments of fixed keys as unlocking a lock,m not just the type. example: two levers may open two different doors). current implementation: can only unlock locks on outgoing edges of the node they are assigned to

*implementation*:
- do not add keys to inventory of neighbors

- #todo("add example")

=== Soft Gates

- goal: soft gates *can* be passed without the corresponding key, but this should be indicated in the path highlighting.

*implementation*:
- during pathfinding/unlock checks, ignore soft-gate locks
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

#pseudocode(
    [```
    canUnlock(K, L):
        if L = ∅
            return TRUE
        unlockingKeysets = required(l1) × ... × required(ln)
        if ∃ U ∈ unlockingKeysets where U ⊆ K:
            return TRUE
        else
            return FALSE
    ```],
    "Function checking whether a set of locks L can be unlocked by keys K, considering consumable keys"
)

- note: subset of multiset
- consider the same example as earlier, except now keys of type $X$ are consumable, so to unlock the two locks $A$ and $B$, now either two keys of type $X$ or one key of type $X$ and one of type $Y$ are needed.

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

#pseudocode(
    [```
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
    ```],
    "Function removing keys required to unlock all locks in L from K"
)

#todo("review pseudocode correctness")

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
- alternative used here: track states as well as nodes. nodes are re-added to queue iff they have a different inventory assigned to them than in previous encounters -> only duplicate nodes as needed
	- for each node, maintain inventories it has been visited with
		- only re-visit with a different inventory
	- add limiting constant for revisits
	- also maintain unlocked edges

#todo("extend example")

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
    caption: "Main Loop of Pathfinding Algorithm with Locks & Keys (Extended)",
    gap: 2em
  )
)

=== Example

- #todo("example screenshot from pixe")

== Options/Settings

- per-chart basis settings regarding pathfinding and locks/keys. for pathfinding, locks/keys can be enabled -> performance improvement for projects/charts without locks/keys. for locks/keys: toggle for consumable keys being consumed during pathfinding (source for complexity in calculation), toggle for soft locks being visualized.
- extendability: tab structure (currently single tab only), so UI is set up for future extension with chart-specific settings (e.g., #todo("think of examples"))

#figure(
  image("assets/04/chart-settings.png", width: 45%),
  caption: "Settings modal"
)

== Code Architexture

- building on implementation for diagrams @impl-diagrams, pathfinding itself has higher complecity -> refactor into multiple files/composables

#todo("add diagram for code architecture + interactions?")

modular architecture for extendability and maintainability. 4 main components:

- `PathCalculation`: main algorithm loop/logic
- `PathUnlocking`: logic specific to unlocking/key consumption
- `PathResult`: data type for results + computed values
- `PathStyling`: styling of edges/nodes based on results

== Full Algorithm

- #todo("make diagram of full algorithm?")

== Testing

- #todo("describe test cases")
- mainly exploratory testing
- smaller charts: target specific configurations
- larger chart: eastern palace -> sanity check on performance. #todo("count nodes"). 

== Limitations and Future Work

- fixed keys for non-adjacent locks
- in pathfinding: temporary, reversible, collapsible locks
- difficulty estimation #todo("add citation")
- recommendations for lock/key types #cite(<dormansCyclicGeneration2017>)
- LLM-based consistency check with descriptions
- implementation: currently done in frontend. reasonably performant up to around 50 nodes at least, but for other use cases, larger graphs may be needed #todo("add citations for game datasets with lots of quests/story elements. e.g. baldurs gate?"). may benefit from porting to backend + specialized algorithm. trade-off: maintainability/extendability?

#load-bib()