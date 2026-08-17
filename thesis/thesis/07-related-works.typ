#import "../utils.typ": todo
#import "../bib.typ": load-bib

= Related Works <id>

== Lock-and-Key Puzzles

A lot of research concerning lock-and-key puzzles revolves around procedural generation of dungeons or levels with locks and keys #cite(<pereiraEvolvingDungeonMaps2018>), #cite(<ruelaEvolvingLockandkeyPuzzles2018>), #cite(<vianaFeasibleInfeasibleTwoPopulation2022>).

In that context, any analysis of lock-and-key puzzles is done automatically and with the goal of generating a variety of puzzles and is concerned with many parameters that users of pix:e would model manually, such as the number of nodes or density of distributed keys.

Automated analysis of lock-and-key puzzles in terms of feasibility or fitness could be integrated into pix:e's analysis functionalities to further guide game designers in the process of designing structures with locks and keys.
However, such an implementation was out of scope for this thesis.

== Inventory-Based Search

As inventories are a highly relevant concept in games, inventory-based path planning has been studied in the context of games.
For instance, #cite(<aversaPathPlanningInventoryDriven2015>) present a so-called inventory-based jump-point search.
Like the algorithm implemented in this thesis, it is based on the concept of an inventory.
However, it is grid-based and focuses more on use-cases such as path planning on in-game maps, which imposes different constraints on how the search space may be explored.

//#cite(<aversaPruningPreprocessingMethods2016>, form: "prose") present pruning and pre-processing methods for inventory-aware pathfinding in the context of grid maps.


//== Petri Nets

//#todo("explain petri nets")

//- difference: focus/targets a different problem, petri nets consider time to model concurrency in distributed systems. associated algorithms are more about reachability
//- bridge:



#load-bib()