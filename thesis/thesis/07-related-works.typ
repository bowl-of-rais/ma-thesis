#import "../utils.typ": todo
#import "../bib.typ": load-bib

= Related Works <id>

== Inventory-Based Search Algorithms

#todo("explain concept and what of it is relevant to here, what of it is not")

- context: inventory relevant in games, impact on path planning/finding 
- difference: inventory-based jump-point search #cite(<aversaPathPlanningInventoryDriven2015>) is grid-based. statechart could be mapped to grid, but would probably be suboptimal because nodes have generally low rank and don't necessarily conform to neighboring structure of a grid. - bridge: concept of inventory is still relevant, though.

#cite(<aversaPruningPreprocessingMethods2016>, form: "prose") presents pruning and pre-processing methods for inventory-aware pathfinding in the context of grid maps.

== Petri Nets

#todo("explain petri nets")

- difference: focus/targets a different problem, petri nets consider time to model concurrency in distributed systems. associated algorithms are more about reachability
- bridge:

== Analysis of Lock-and-Key Puzzles

A lot of research concerning the intricacies of lock-and-key puzzles revolves around procedural generation of dungeons or levels with locks and keys.
Therefore, any analysis of lock-and-key puzzles is done automatically and with the goal of generating a variety of puzzles.
Typically, locks and keys in this low-level context refer to literal locks and keys.
- context: approaches for procedural generation of lock-and-key puzzles: #cite(<pereiraEvolvingDungeonMaps2018>), #cite(<ruelaEvolvingLockandkeyPuzzles2018>), #cite(<vianaFeasibleInfeasibleTwoPopulation2022>)
- In contrast, this thesis revolves about modeling and analyzing game progression with locks and keys.
- bridge: generation involves guidelines/feasibility checks to ensure puzzles are solvable, and may be jumping-off point for analysis of lock-and-key puzzles

#load-bib()