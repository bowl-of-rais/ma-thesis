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

#let pseudocode(content, caption, label) = {
set par(justify: false)
[#figure(
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
)#label]}

= Locks and Keys <impl-lk>

The second feature this thesis contributes to pix:e is the concept of locks and keys.
Unlike the pacing diagrams, this is a novel functionality that did not exist in PaceMaker.

As described in @bg-locks-and-keys, the terms "locks" and "keys" can refer to both literal lock and key items as well as more abstract concepts that present a challenge or obstacle and the respective solutions.

Locks and keys can be used both low-level (e.g., to model individual puzzles/dungeons) or high-level puzzles (e.g., to model storylines and their prerequisites).
The implementation is thus focused on flexibility and customizability to account for a wide range of use cases.
Additionally, lock-and-key puzzles have a high complexity ceiling #todo("add citation"), so a dedicated functionality for their analysis and verification has potential for high impact.

This section first concretizes the requirements for the modeling of locks and keys and the associated solvability analysis.
It then describes how the representations for locks and keys are made available to users in pix:e.
Finally, it details the extension of the pathfinding functionality by logic specific to different lock and key types.
#todo("rest of the subsections?")

== Requirements <lk-requirements>

The previously described taxonomy (see @bg-lock-key-taxonomy) serves as the main reference for the requirements for modeling locks and keys in pix:e.
This subsection first describes how the different aspects of locks and keys are implemented in pix:e, presents the resulting data model and outlines the main analysis functionality provided for lock-and-key puzzles.

=== Locks and Keys in the Statechart

#cite(<brownHowMyBoss2026>) presents a graph-based representation of how locks and keys are distributed throughout a dungeon for the purpose of analyzing existing level designs.
The focus of that approach lies on determining where locks and keys are located in relation to each other and examining any resulting dependencies.
However, it includes a key idea that is used in this work to integrate locks and keys into the pix:e statechart: keys are found in rooms, while locks are encountered when moving from one room to another.
In the context of the pix:e statechart, users should thus be able to place keys on nodes and locks on edges.
//For instance, a node may represent a room or level where players obtain a specific item.
//They may then require this item to progress to another room or level, which would be represented by a lock on the corresponding edge.
This approach translates to high-level modeling: Nodes may be used to represent entire levels where players obtain a specific item that is required to progress to the next level, or nodes may correspond to specific quests that players have to complete (the completion itself being the key) to start subsequent ones.

=== Implementation of Specific Lock and Key Aspects

The first lock feature described in the taxonomy is for how long it stays unlocked (*permanent, temporary, reversible, collapsible*).
This is modeled using the attribute `unlockMode` for locks, which can then be referred to in the pathfinding logic.
The distinction between *valve* s and *asymmetrical* locks can be modeled via the choice of edge directionality.
Valves may be modeled by uni-directional edges, while asymmetrical edges can be represented using a single bidirectional edge with locks.
*Soft gates* are modeled by a flag (`soft_gate`) on lock types and then checked during pathfinding.
In the current implementation, all locks are assumed to be *safe*, so *unsafe* locks cannot be modeled.
#todo("reasoning?")

As for keys, the attribute `type` with the possible values `ability`, `item`, and `other` can be used to distinguish between *single-purpose or multi-purpose* keys.
This also captures the concept of keys as abstract tokens.
In the current implementation, this is just a marker and does not impact how keys are represented or handled.
*Particularity or non-particularity* of keys is implicitly modeled as a characteristic of a lock, i.e., which keys a lock may be unlocked by.
The aspects of keys being either *consumable or persistent* and possibly *fixed* are modeled by respective flags on keys (`consumable` and `fixed`) and referred to in the pathfinding logic.

=== Resulting Data Model <lk-data-model>

The data model resulting from the previously described modeling approaches can be seen in @fig:lk-data-model.

#figure(
  image("assets/04/lock-key-data-model.drawio.png"),
  caption: "Data model for locks and keys"
) <fig:lk-data-model>

#todo("review multiplicities") #todo("add soft gate flag")

Similar to the pre-existing implementation of `PxComponent`s, the data model distinguishes between lock and key _definitions_ and _assignments_.
The definitions are used to represent different _types_ of locks and keys, including the aforementioned variations.
They may then be assigned to edges or keys respectively, and each assignment corresponds to an instance of the lock or key type represented by the associated definition.
The multiplicities in @fig:lk-data-model portray the following conditions: 
1. A lock definition may be assigned multiple key definitions that unlock it. The same key definition may also be assigned to multiple lock definitions as an unlocking key type. Additionally, both lock and key definitions can be reused across assignments.
2. Each edge or node may not have more than one assignment of the same definition.  Assignments record a `count` to model multiplicity of instantiations.

=== Analysis Functionality

A fundamental question for lock-and-key puzzles is the one of solvability.
Hence, solvability analysis is the main analysis functionality concering locks and keys implemented in this work.

Locks and keys translate to conditional transitions in the statechart #todo("reference?"), which in turn affects pathfinding.
By integrating the constraints placed on pathfinding via lock and key assignments into the pathfinding logic, users of the tool can assess solvability based on lock and key placements and judge their impact on possible progression paths throughout a level or game.
This includes the existing feedback on whether a path between two selected nodes exists or not, as well as hints about possible pitfalls.

== Creation and Visualization of Locks and Keys <lk-creation-visualization>

=== Defining Lock and Key Types

As described in @lk-data-model, lock and key definitions are treated as separate concepts from their concrete instantiations.
Users thus need to first define their desired lock and key types before they can use them in the PxChart.

Both lock and key definitions are created and displayed on same page (see @lk-defs) so users may consult existing key definitions while creating lock definitions and vice versa.
The layout pins the creation forms on the left-hand side of the page, while respective `ScrollArea`s for existing lock and key definitions are placed next to it.
The forms offer help texts and indicators for necessary inputs to assist users.

#figure(
  image("assets/04/lock-key-definitions-page.png"),
  caption: "Page 'Lock and Key Definitions'"
) <lk-defs>

=== Instantiating Locks

//- same as keys, multiple instances of same definition possible per edge, see data model.
Edges are chart-specific and not represented in the UI except for in the chart itself, so users must be able to instante locks on the chart page.
To ensure users understand how to use the functionality, the UI should make it clear that adding a lock to an edge is specific to that edge.
The most straight-forward approach would be to attach a button or menu to each edge.
However, the Vueflow framework does not offer a built-in context menu for edges.
A possible future improvement would be a custom edge implementation to simulate a context menu, which could also include other actions like edge deletion.
This was out of scope for this work.
The currently implemented workaround is thus a button in the chart's toolbar that is only visible when exactly one edge is selected.
//benefit for implementation: edge selection is easily detected.

Clicking the button opens the lock creation modal (see @edit-lock-modal), which shows and overview of all available lock definitions and their respective instance counts on the selected edge.
Assignments of multiple kinds of locks can be added or removed in the modal by adjusting the respective counts.
The key icon in each row shows the unlocking key definitions for the corresponding lock type on hover.

#todo("screenshot of button?")

#figure(
  image("assets/04/edit-lock-modal.png", width: 50%),
  caption: "Modal for creating/editing lock assignments for an edge"
) <edit-lock-modal>

=== Instantiating Keys

//- multiple instances of same definition possible per node as defined in data model
The UI and process for instantiating keys is designed to be analogous to the existing PxComponents, as they are both centered around nodes.

An icon button in the node card (see @node-with-keys) opens a modal (see @key-creation-modal) where users can choose a key definition from all definitions without an existing assignment and respective count.
Both are technically required, the count has default value 1.
Key assignments in nodes are represented by chips, analogously to PxComponents (see @node-with-keys).
The chips show the count and the definition name and include a button for deletion.

#grid(
  columns: 2,
  inset: 5pt,
  align: bottom,
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

One limitation of this implementation is that there is no way to edit and existing assignments.
This is already a limitation of the PxComponents.
Both would likely benefit from refactoring for easier editing.

== Pathfinding with Locks and Keys <lk-pathfinding>

As described previously, integrating locks and keys into the pathfinding functionality provides a type of solvability analysis for lock-and-key puzzles.
This section describes how the pathfinding algorithm implemented in @impl-diagrams was first extended to account for basic locks and keys and then some of their variants.

=== Dijkstra with Basic Locks and Keys

As an initial step, the previously implemented pathfinding algorithm was extended by the general concept of locks and keys.
This basic version assumes permanent unlock of all lock types, ignores whether keys are consumable or fixed, and treats soft gates as regular locks that always require a key.
In short, the main addition to the algorithm at this point is a check whether edges can be traversed based on the keys collected up to that point.

This is implemented using node-specific inventories, which track any keys collected along the path to a specific node and are used to determine whether edges can be unlocked.
	- inventory similar to #cite(<aversaPathPlanningInventoryDriven2015>) #todo("")
Internally, this is modeled via so-called `PxKeySet`s, which are mappings of key definitions to counts that aggregate multiple instantiations of the same key definition into one.
In its basic form, the inventory associated with a node reflects keys collected along the shortest path to this node as well as keys made available in this node.
Inventory contents are propagated to neighboring nodes during iteration.
In later implementation steps, the concept is extended to account for consumable keys and backtracking.

==== Unlocking Function

A central part of the algorithm for pathfinding with locks and keys is the `canUnlock()` function.
Given (multi-)sets of locks and keys, it determines whether the locks can be unlocked.
This check as a high complexity (see @code:canunlock-basic) due to the fact that an edge may be assigned multiple locks, each of which may be unlockable by multiple key types.
While there is a potential for exponential blowup, no optimization is currently implemented as the expected case is less complex.
#todo("citation?")

@code:canunlock-basic shows the logic behind the `canUnlock` function given a set of keys in inventory $K$ and locks on edge $L$:

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
    "Function checking whether a set of locks L can be unlocked by keys K",
    <code:canunlock-basic>
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

The main constraint concerning fixed keys is that they can only be used within the node they are assigned to.
This aspect is easily implemented by _not_ propagating fixed keys in a node to its neighbor's inventories.

One limitation of the current data model and implementation is that there is no way to model remote fixed keys.
This would require additional information, in particular whether a specific key instantiation unlocks a specific lock instantiation.
This additional layer was deemed out of scope for this work.
//example: two levers may open two different doors).
For this reason, the current implementation can only model fixed keys that unlock locks on outgoing edges of the one node they are assigned to.
//- #todo("add example")

=== Soft Gates

Soft gates *can* be passed without the corresponding key, but doing so renders the following path risky or challenging.
This circumstance should be reflected in the path highlighting.

As soft gates can technically be passed without a key, locks marked as such are ignored initially during pathfinding.
If a path has been found, it is re-traced to determine whether the keys that could unlock the soft gate are available or not.
If not, all nodes in the path after the soft-gated edge are highlighted in yellow ("warning").

- #todo("add example from pixe")

=== Consumable Keys and Soft-Lock Detection

To reflect consumability of keys, the node-specific key inventories need to be extended.

Due to the fact that a lock may be unlockable by multiple (potentially consumable) keys, the keys available in a node now also depend on a possible _choice_ of which key was used to unlock a specific lock.

This circumstance is modeled by considering multiple variants of a node's inventory.
The underlying idea is one of 'different realities':
Nodes exist in different realities if they are approached with different inventories.

This is implemented by maintaining a set of `PxKeySets` per node.
In the `canUnlock`, the multiplicity of consumable keys is considered.
When updating the inventories of neighbor nodes during iteration, the consumed keys are removed from the inventory.
In case of multiple options for consumed keys, multiple keysets are added to the neighboring node.

==== Pathfinding with Consumable Keys

===== Extending Unlocking Check

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
    "Function checking whether a set of locks L can be unlocked by keys K, considering consumable keys",
    <code:canunlock-consumable>
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

===== Removing Consumable Keys from Inventory

given inventory $I$ containing multisets of keys $K$ and locks on edge $L$:

#pseudocode(
    [```
    removeConsumable(I, L):
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
    "Function removing keys required to unlock all locks in L from K",
    <code:remove-consumable>
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

#todo("extension of data model to implement bidirectional edges")

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

== Chart Settings

To prevent unnecessary complexity during pathfinding in cases where specific lock or key features are not needed, settings were introduced as part of this implementation.
The settings are persisted on a per-chart basis.

Currently, the settings include general pathfinding settings and settings specific to lock and key types.
For the pathfinding, locks/keys can be enabled or disabled entirely.
This reduces pathfinding complexity greatly for projects or charts that do not use locks and keys.
For locks/keys, users can choose whether consumable keys being consumed during pathfinding, and whether soft locks should be calculated, both sources of additional complexity.

The modal (see @fig:settings-modal) was implemented with a tab structure, so the UI is set up for future extension with chart-specific settings that may be unrelated to pathfinding (e.g., #todo("think of examples")).

#figure(
  image("assets/04/chart-settings.png", width: 45%),
  caption: "Settings modal"
) <fig:settings-modal>

== Code Architexture

After building the initial pathfinding implementation for diagrams @impl-diagrams, the pathfinding calculation is much more extensive.
The code was thus refactored into multiple files/composables for purposes of further extendability and maintainability. #todo("sth sth oss")

It was broken down into 4 main components:

- `PathCalculation`: main algorithm loop/logic
- `PathUnlocking`: logic specific to unlocking/key consumption
- `PathResult`: data type for results + computed values
- `PathStyling`: styling of edges/nodes based on results

which interact as shown in @fig:modularization:

#todo("add diagram for code architecture + interactions?")

#figure(
  image("../images/dummy_image.svg", width: 50%),
  caption: "Modular architecture for pathfinding calculation"
) <fig:modularization>

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