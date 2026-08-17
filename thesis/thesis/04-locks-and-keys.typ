#import "../utils.typ": todo
#import "../bib.typ": load-bib

//#import "@preview/lovelace:0.3.1": *

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

= Solvability Analysis with Locks and Keys in pix:e <impl-lk>

The second feature this thesis contributes to pix:e is the integration of locks and keys into the modeling and pathfinding functionalities.
Unlike the pacing diagrams, this is a functionality that did not exist in PaceMaker.

As described in @bg-locks-and-keys, the terms "locks" and "keys" can refer to both literal lock and key items as well as more abstract concepts that present a challenge or obstacle and the respective solutions.
Complementary to the ability of PxCharts to model player experience in various levels of granularity, locks and keys can thus be used in both a low-level (e.g., when modeling individual puzzles/dungeons) and high-level context (e.g., when modeling storylines and their prerequisites).
The design of lock and key modeling capabilities is thus focused on flexibility and customizability to account for a wide range of use cases.

Locks and keys attach an additional dimension to the non-linear structure of games and thus fundamentally impact how players progress through a game.
This extension of pix:e's player experience modeling capabilities expands its capacities to cover a variety of further use cases.
Additionally, lock-and-key puzzles have a high complexity ceiling.
A dedicated functionality for their analysis and verification therefore has potential for high impact.

Lock-and-key puzzles can affect player experience in various ways.
For instance, as described by #cite(<brandseLevelFlowPatterns2023>, form: "prose"), lock-and-key puzzles are a common way to direct when and where players encounter a challenge or receive a reward, which greatly impacts player experience.
The puzzles themselves also present a type of challenge, which, if disproportionately difficult or complex, may lead to player frustration.
In some instances, lock-and-key puzzles are also used to make exploration a focal point of player experience #cite(<ruelaEvolvingLockandkeyPuzzles2018>).

This chapter first specifies the requirements for the modeling of locks and keys and the associated solvability analysis.
It then describes how representations for locks and keys are made available to users in pix:e.
Subsequently, @lk-pathfinding details the extension of pix:e's pathfinding functionality by logic specific to different lock and key types, and some related refactoring.
Finally, the testing approach, an implementation of settings, and the limitations of lock-and-key related features are described.

== Requirements <lk-requirements>

The previously described taxonomy by Dormans (see @bg-locks-and-keys) serves as the main reference for the requirements for modeling locks and keys in pix:e.
This subsection first describes how the different aspects of locks and keys are implemented in pix:e, presents the resulting data model and outlines the main analysis functionality provided for lock-and-key puzzles.

=== Locks and Keys in the Statechart

#cite(<brownHowMyBoss2026>, form: "prose") presents a graph-based representation of how locks and keys are distributed throughout a dungeon for the purpose of analyzing existing level designs.
It includes a basic idea that is used in this work to integrate locks and keys into the pix:e statechart: keys are found in rooms, while locks are encountered when moving from one room to another.
In the context of the pix:e statechart, users should thus be able to place keys on nodes and locks on edges.
//For instance, a node may represent a room or level where players obtain a specific item.
//They may then require this item to progress to another room or level, which would be represented by a lock on the corresponding edge.
This approach translates to high-level modeling: Nodes may be used to represent entire levels where players obtain a specific item that is required to progress to the next level, or nodes may correspond to specific quests that players have to complete (the completion itself being the key) to start subsequent ones.

=== Implementation of Specific Lock and Key Aspects

The first lock feature described in the taxonomy is for how long it stays unlocked (*permanent, temporary, reversible, collapsible*).
This is modeled using the attribute `unlockMode` for locks, which can then be referred to in the pathfinding logic.
The distinction between *valve* s and *asymmetrical* locks can be modeled via the choice of edge directionality.
Valves may be modeled by uni-directional edges, while asymmetrical locks can be represented on a single bidirectional edge.
*Soft gates* are modeled by a flag (`softGate`) on lock types and then checked during pathfinding.
As the main analysis functionality implemented for locks and keys is a solvability analysis, the current implementation focuses on *safe* locks only.

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

//#todo("review multiplicities")

Similar to the pre-existing implementation of `PxComponent`s (see @initial-pixie), the data model distinguishes between lock and key _definitions_ and _assignments_.
The definitions are used to represent different _types_ of locks and keys, including the aforementioned variations.
They may then be assigned to edges or keys respectively, and each assignment corresponds to an instance of the lock or key type represented by the associated definition.
The multiplicities in @fig:lk-data-model portray the following conditions: 
1. A lock definition may be assigned multiple key definitions that unlock it. The same key definition may also be assigned to multiple lock definitions as an unlocking key type. Additionally, both lock and key definitions can be reused across assignments.
2. Each edge or node may not have more than one assignment of the same definition.  Instead, assignments record a `count` to aggregate multiple instantiations of the same lock or key type.

=== Analysis Functionality

A fundamental question for lock-and-key puzzles is that of solvability.
Hence, solvability analysis is the main analysis functionality concerning locks and keys implemented in this work.
Locks and keys introduce conditional transitions to the statechart, which in turn affects pathfinding.
By integrating the constraints placed on pathfinding via lock and key assignments into the pathfinding logic, users of the tool can assess solvability based on lock and key placements and judge their impact on possible progression paths throughout a level or game.
This includes the visual feedback (as implemented in @impl-diagrams) on whether a path between two selected nodes exists or not, as well as hints about possible pitfalls.

== Creation and Visualization of Locks and Keys <lk-creation-visualization>

To use locks and keys, users first need to define their desired lock and key types.
Then, then can assign locks to edges in a `PxChart` and keys to `PxNode`s.
In the UI, lock assignments and key assignments are referred to as `PxLock`s and `PxKey`s respectively for brevity.

=== Defining Lock and Key Types

As described in @lk-data-model, lock and key definitions are treated as separate concepts from their concrete instantiations.
Users thus need to first define their desired lock and key types before they can use them in the PxChart.

Both lock and key definitions are created and displayed on same page (see @lk-defs) so users may consult existing key definitions while creating lock definitions and vice versa.
The layout pins the creation forms on the left-hand side of the page, while respective `ScrollArea`s for existing lock and key definitions are placed next to it.
The forms offer help texts and indicators for necessary inputs to assist users.

#figure(
  image("assets/04/pixie-lock-key-definitions-page.png"),
  caption: "Page 'Lock and Key Definitions'"
) <lk-defs>

=== Instantiating Locks <instantiating-locks>

//- same as keys, multiple instances of same definition possible per edge, see data model.
Edges are chart-specific and not represented in the UI except for in the chart itself, so users must be able to instantiate locks on the chart page.
To ensure users understand how to use the functionality, the UI should make it clear that adding a lock to an edge is specific to that edge.
The most straight-forward approach would be to attach a button or menu to each edge.
However, the library that is currently used to implement `PxChart`s (VueFlow) does not offer a built-in context menu for edges.
The currently implemented workaround is thus a button in the chart's toolbar that is only visible when exactly one edge is selected.
//benefit for implementation: edge selection is easily detected.

Clicking the button opens the lock creation modal (see @edit-lock-modal), which shows an overview of all available lock definitions and their respective instance counts on the selected edge.
Assignments of multiple kinds of locks can be added or removed in the modal by adjusting the respective counts.
The key icon in each row shows the unlocking key definitions for the corresponding lock type on hover.

#figure(
  image("assets/04/pixie-edit-lock-modal.png", width: 50%),
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
      image("assets/04/pixie-add-key-modal.png"),
      caption: "Modal for creating a key assignment for a node"
    ) <key-creation-modal>
  ]),
  grid.cell([
    #figure(
      image("assets/04/pixie-node-with-key-assignment.png", width: 75%),
      caption: "Visual representation of two key assignments in a node"
    ) <node-with-keys>
  ])
)

== Pathfinding with Locks and Keys <lk-pathfinding>

As described previously, integrating locks and keys into the pathfinding functionality provides a type of solvability analysis for lock-and-key puzzles.
This subsection describes how Dijkstra's algorithm was first extended to account for basic locks and keys and then some of their variants.

=== Dijkstra with Basic Locks and Keys

As an initial step, the previously implemented pathfinding algorithm was extended by the general concept of locks and keys.
This basic version assumes permanent unlock of all lock types, ignores whether keys are consumable or fixed, and treats soft gates as regular locks that always require a key.
In short, the main addition to the algorithm at this point is a check whether edges can be traversed based on the keys collected up to that point.
This is implemented using node-specific inventories inspired by #cite(<aversaPathPlanningInventoryDriven2015>, form: "prose"), who present a path planning algorithm in the context of grid-based game maps.
The general idea behind inventories is to track any keys collected along the path to a specific node in order to determine whether the adjacent edges can be unlocked.
Internally, this is modeled via so-called `PxKeySet`s, which are mappings of key definitions to counts that aggregate multiple instantiations of the same key definition into one.
In its basic form, the inventory associated with a node reflects keys collected along the shortest path to this node as well as keys made available in this node.
Inventory contents are propagated to neighboring nodes during iteration.
In later implementation steps, the concept is extended to account for consumable keys and backtracking.
On successful path calculation, the final inventory in the target node is saved. 
This enables the repeated execution of the algorithm with different starting points in the case where users select more than two nodes to find a path between.

// #todo("add diagram about inventory propagation")

==== Unlocking Function <unlocking-basic>

A central part of the algorithm for pathfinding with locks and keys is the `canUnlock()` function.
Given sets of locks and keys, it determines whether the locks can be unlocked.
This check has a high complexity (see @code:canunlock-basic) due to the fact that an edge may be assigned multiple locks, each of which may be unlocked by multiple key types.
While this circumstance harbors a potential for exponential blowup, the expected case is less complex.
Any related optimization was therefore deemed not a priority in this work.

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

The following example illustrates an unlock check as performed by this function.

@unlock-example-graph shows a statechart in which three locks are assigned to one edge:
- lock $A$, which can be unlocked by keys of type $X$ or $Y$
- lock $B$, which can be unlocked by keys of type $X$
- lock $C$, which can be unlocked by keys of type $Z$

#figure(
  image("assets/04/example-unlock-check-graph.drawio.png", width: 75%),
  caption: ""
) <unlock-example-graph>

/*
Ignoring consumable keys: to unlock this edge, one could use the key sets ${X, Z}$ or ${X, Y, Z}$. If either is a subset of the available keys when encountering the edge, it can be unlocked.

#pad(
  rest: 10pt,
  figure(
    image("assets/04/can-unlock-without-consume.drawio.png", width: 50%),
    caption: "Calculation of unlocking keysets",
    gap: 2em
  )
)
*/

@unlock-example-success shows a case in which the edge can be unlocked: the available inventory $I = {X, Z}$ contains at least one matching key for each lock.
In contrast, @unlock-example-failure shows a case in which the edge cannot be unlocked. The inventory $I = {X, Y}$ is not a superset of either unlocking keyset and does not contain a matching key for lock $C$.

#grid(
  columns: 2,
  grid.cell[
    #figure(
      image("assets/04/example-unlock-check-success.drawio.png"),
      caption: ""
    ) <unlock-example-success>
  ],
  grid.cell[
    #figure(
      image("assets/04/example-unlock-check-failure.drawio.png"),
      caption: ""
    ) <unlock-example-failure>
  ],
)

// #todo("add example in pix:e?")

==== Dijkstra's Algorithm with Locks and Keys

@loop-basic visualizes Dijkstra's algorithm including the modifications that account for basic locks and keys.

#pad(
  rest: 10pt,
  [#figure(
    image("assets/04/lock-key-pathfinding-basic.drawio.png", width: 80%),
    caption: "Main Loop of Pathfinding Algorithm with Locks & Keys (Basic)",
    gap: 2em
  ) <loop-basic> ]
)

//==== Example Iteration
//
//- #todo("add small example of iteration")

=== Fixed Keys

The main constraint imposed by the definition of fixed keys is that they can only be used within the node they are assigned to.
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
If not, all nodes in the path after the soft-gated edge are highlighted in yellow ("warning") as seen in @soft-gated-path.

#figure(
  image("assets/04/pixie-soft-gate-example.png"),
  caption: "Partially soft-gated path"
) <soft-gated-path>

=== Consumable Keys and Soft-Lock Detection

To enable the consumption of keys, the node-specific key inventories need to be extended.
Due to the fact that a lock may be unlocked by multiple (potentially consumable) keys, the keys available in a node now also depend on a possible _choice_ of which key was used to unlock a specific lock.
This circumstance is modeled by considering multiple variants of a node's inventory.
The underlying idea is one of 'different realities':
Nodes exist in different realities if they are approached with different inventories.
This is implemented by maintaining a set of `PxKeySets` per node.
In the `canUnlock`, the multiplicity of consumable keys is considered.
When updating the inventories of neighbor nodes during iteration, the consumed keys are removed from the inventory.
In case of multiple options for consumed keys, multiple keysets are added to the neighboring node.

==== Pathfinding with Consumable Keys

#h(1.8em)
===== Extending Unlocking Check
@code:canunlock-consumable shows how the extended `canUnlock` function performs the unlock check considering consumable keys.
It takes a multiset of keys in inventory $K$ and locks on edge $L$ as inputs.

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

The crucial difference to the version without consumable keys is that by requiring the unlocking multi-keyset $U$ to be a subset of the available multi-set of keys $K$, the required multiplicity of consumable keys is accounted for.

@unlocking-multi illustrates an example analogous to the example presented in @unlocking-basic.
In this case, keys of type $X$ are consumable, so to unlock the two locks $A$ and $B$ without a key of type $Y$, two keys of type $X$ are necessary.
The inventory $I = {X, Z}$, with which all locks in the initial example could be unlocked, cannot unlock all three locks when $X$ is consumable.

#figure(
  image("assets/04/example-unlock-check-consumable-failure.drawio.png", width: 75%),
  caption: ""
) <unlocking-multi>

/*
#pad(
  rest: 10pt,
  [#figure(
    image("assets/04/can-unlock-with-consume.drawio.png", width: 50%),
    caption: "Calculation of unlocking keysets as multisets",
    gap: 2em
  ) <unlocking-multi-check> ]
)
*/

#h(1.8em)
===== Removing Consumable Keys from Inventory
In contrast to the `canUnlock` function, which only checks whether a given keyset may unlock a set of locks, the removal of consumable keys from the propagated inventory requires information about which specific keys might have been used.

@code:remove-consumable contains the `removeConsumable` function. Given an inventory $I$ containing multisets of keys $K_i$ and locks on edge $L$, it determines all keysets that are subsets of any of the unlocking keysets and computes an inventory variant without the consumable keys for each.

#pseudocode(
    [```
    removeConsumable(I, L):
        if L = ∅
            return TRUE
        consumableRequirements = { l ∈ L. ∃ key. key ∈ unlockedBy(l) and consumable(key)}	
        unlockingKeysets = required(l_1) × ... × required(l_n) for l_i ∈ consumableRequirements 
        updatedInventory = []
        for K_i ∈ I:
            for U ∈ unlockingKeysets: 
                if K_i ⊆ U:
                    updatedInventory.push(K_i - { key ∈ U. consumable(key)})	
        return updatedInventory
    ```],
    "Function removing keys required to unlock all locks in L from K",
    <code:remove-consumable>
)

/*
#pad(
  rest: 10pt,
  figure(
    image("assets/04/remove-consumed.drawio.png", width: 50%),
    caption: "Calculation of unlocking keysets for key consumption",
    gap: 2em
  )
)

- $I = \{X, X, Z\}$ -> $\{Z\}$

- #todo("example in pixie for consumable keys")
*/

==== Softlocks

Consumable keys may give rise to so-called *soft-locks*.
As described by #cite(<mawhorterSoftlockDetectionSuper2021>, form: "prose"), a softlock occurs when players may get stuck in a level or game due to how they traverse it.
The authors formally define gameplay to be softlock-free if 
"it is possible to reach the goal state from every reachable state"
#cite(<mawhorterSoftlockDetectionSuper2021>).
In the context of a path calculated in pix:e with locks and keys, a potential softlock thus occurs when a path may or may not be found depending on the choice of (consumable) keys used. 
To rephrase it in terms of the aforementioned definition, a path is soft-lock-free if it is possible to reach the target node from every other node on the path, no matter which inventory it was visited with (or: _state_ it was visited in).
@softlock-example shows a configuration with a potential soft-lock in node $B$. Assuming an initial inventory $I = {X, Y}$ with both keys of type $Y$ being consumable, the edge from node $B$ to $C$ cannot be unlocked if key $Y$ was already used to unlock the edge from $A$ to $B$.

#pad(
  rest: 10pt,
  [#figure(
    image("assets/04/soft-lock-example.drawio.png", width: 80%),
    caption: "Example: Soft-lock",
    gap: 2em
  ) <softlock-example> ]
)

#h(1.8em)
In terms of the implementation, a potential soft-lock state occurs when an edge may be unlocked with some, but not all available keysets.
During removal of consumable keys (@code:remove-consumable), keysets that do not unlock the given edge are removed from the updated inventory entirely, as the edge could not be traversed with those sets and they should thus not be propagated to the neighboring node.
A comparison of inventory length before and after consumption is then used to verify whether a potential soft-lock occurs in the current node.

If a soft-lock is identified during pathfinding, the node in which it occurs is highlighted in blue ("info") as seen in in @pixie-soft-lock.

#figure(
    image("assets/04/pixie-soft-lock-example.png"),
    caption: ""
) <pixie-soft-lock>

// #todo("softlock not found in user study?")

== Bidirectional Edges and Backtracking

One major limitation of the VueFlow library (and thus the initial statechart in pix:e) is the lack of native support for bidirectional edges.
Bidirectional edges are, however, crucial for modeling non-linear gameplay.
For a simple example, consider a dungeon where players may go back to a previous room.
This sub-section thus describes the modeling of bidirectional edges themselves and how the pathfinding algorithm was extended to account for bidirectional edges.

=== Modeling Bidirectional Edges

While the framework does not support bidirectional edges, it does allow for arbitrary data to be assigned to edges and used for styling.
Hence, a flag `bidirectional` was added to edges to indicate whether an edge was uni- or bidirectional.
Edges were then configured to render with different markers: regular arrows for uni-directional edges, no marker for bi-directional edges.
Due to the limitations described in @instantiating-locks, another toolbar button was added to allow users to change the directionality of a selected edge (see @edge-direction-button).

#figure(
  image("assets/04/pixie-edit-edge-buttons.png"),
  caption: "Button (rightmost in the toolbar) for toggling directionality of a selected edge"
) <edge-direction-button>

=== Backtracking in Pathfinding

With the implementation of bidirectional edges, the pathfinding algorithm was extended by backtracking.

While an implementation of backtracking would have been possible in theory with uni-directional edges, the approach would have been unnecessarily complex.
A bidirectional edge could be modeled using two uni-directional edges, but this would
1. Prevent any distinction between asymmetrical locks and valves
2. Cause additional overhead as an edge would have to be considered unlocked if the edge in the reverse direction is also unlocked
3. Over-complicate the user experience.
The existence of bidirectional edges is thus essential for a viable implementation of backtracking.

By incorporating backtracking, the path calculation can account for cases where cyclic paths are necessary to collect keys.
Such a situation is illustrated in @why-backtracking: starting from $A$ and assuming no key of type $X$ has been collected before, a valid path would have to travel to $B$ and back to $A$ before progressing to $C$.

#pad(
  rest: 10pt,
  [#figure(
    image("assets/04/backtracking.drawio.png", width: 80%),
    caption: "Example where backtracking is necessary",
    gap: 2em
  ) <why-backtracking>]
)

=== Incorporating Backtracking into Dijkstra's Algorithm

In its original form, Dijkstra's algorithm does not find paths with backtracking, as it is designed to find shortest paths and a path with backtracking is always longer than a direct path.
This necessitated an adaptation of the algorithm.

As described previously, the main justification for permitting backtracking is the collection of additional keys.
This circumstance gives rise to the following approach: 
Nodes may be re-added to the queue iff they have a different inventory assigned to them than in previous iterations.
This is implemented by performing Dijkstra's algorithm on _meta-nodes_, which wrap a node, the inventory it is visited with, and the edges that have been unlocked on the prior path.
This way, nodes are only re-visited when needed and the distance of each meta-node from the start node is still as short as possible.

// - parallel universes (- #todo("add citation from julian's paper?"))

/*
==== Inventory Variants: Consumable Keys vs Backtracking

Both this approach and the method used to extend pathfinding with consumable keys consider different inventories per node.
The differing implementation approaches can be justified as follows.

In the case of consumable keys, all variants of a node's inventory were collected along the same path.
While this could also be modelled using meta-nodes, in the context of Dijkstra's algorithm, the distance from the starting node would be identical for all variants.
Additionally, the set of reachable nodes may vary for the different inventory variants, but in the current implementation, all nodes that can be reached by _any_ of the available keysets in a certain node are considered neighbors in the context of Dijkstra's algorithm.
Thus, the path calculation would yield the same result no matter whether different inventories from key consumption are modeled using one and the same node or multiple nodes.
The choice for consumable keys fell on the single-node approach, is that it is precisely what enables a simple detection of soft-locks.

In contrast, backtracking causes nodes to have differing inventories based on which path they were approached on, which also affects their distance from the starting node.
*/

=== Example: Pathfinding with Backtracking in pix:e

As seen in @pixie-backtracking, valid paths that contain backtracking are highlighted the same way as regular paths.

#figure(
    image("assets/04/pixie-example-backtracking.png"),
    caption: ""
) <pixie-backtracking>

== Final Algorithm and Code Architecture

The full algorithm for pathfinding with locks and keys is visualized in @fig:full-algo-modularization.

#figure(
  image("assets/04/lock-key-pathfinding-extended.drawio.png", width: 90%),
  caption: "Final extended Dijkstra's algorithm with modularization"
) <fig:full-algo-modularization>

Compared to the initial pathfinding implementation for diagrams (@impl-diagrams), the additions described in this section make the related code much more extensive.
It was thus refactored into multiple files/composables for purposes of further extendability and maintainability.
// #todo("sth sth open source software and its consequences")

It was broken down into 4 main components:

- `PathCalculation`: main algorithm loop/logic
- `PathUnlocking`: logic specific to unlocking/key consumption
- `PathResult`: data type for results + computed values
- `PathStyling`: styling of edges/nodes based on results

The functional domains of the individual components are highlighted in @fig:full-algo-modularization as well.

/*
== Testing

- #todo("describe test cases")
- mainly exploratory testing
- smaller charts: target specific configurations
- larger chart: eastern palace -> sanity check on performance. #todo("count nodes"). 
*/

== Chart Settings

To prevent unnecessary complexity during pathfinding in cases where specific lock or key features are not needed, settings were introduced as part of this implementation.
The settings are persisted on a per-chart basis.

Currently, the settings include general pathfinding settings and settings specific to lock and key types.
For the pathfinding, locks/keys can be enabled or disabled entirely.
This reduces pathfinding complexity greatly for projects or charts that do not use locks and keys.
For locks/keys, users can choose whether consumable keys being consumed during pathfinding, and whether soft locks should be calculated, both sources of additional complexity.

The modal (see @fig:settings-modal) was implemented with a tab structure, so the UI is set up for future extension with chart-specific settings that may be unrelated to pathfinding.

#figure(
  image("assets/04/pixie-chart-settings.png", width: 45%),
  caption: "Settings modal"
) <fig:settings-modal>

== Limitations

One limitation in the modeling functionality for keys is that there is no way to edit an existing assignment.
This is already a limitation present in the `PxComponent`s.
Due to the conceptual similarities between `PxKey`s and `PxComponent`s, the workflow was implemented to be identical.
However, both would likely benefit from refactoring for easier editing.

Another UI-related limitation are the edge-specific toolbar buttons.

As mentioned previously, not all aspects of lock and key types reflected in the data model are considered in the pathfinding algorithm. This specifically concerns fixed keys for non-adjacent locks and temporary, reversible, and collapsible locks.

A second limitation is that when a path includes backtracking, the current highlighting of the nodes and edges included in the path does not communicate at which point the path backtracks.

Finally, the path calculation is currently implemented in the frontend of the system.
While it is reasonably performant at a chart size of around 40 nodes, there may be use cases that require much larger charts.
// #todo("add citations for game datasets with lots of quests/story elements. e.g. bg3?").
A future improvement could be to port the calculation to the backend and optimize the algorithm.

#load-bib()