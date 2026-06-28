
## Introduction

In the first portion of the study, you have seen how PxCharts can be used to model dungeons from the Legend of Zelda series. Now, we will explore two specific use cases for these kinds of charts:
- lock-and-key puzzles and
- enemy distribution

The next two tasks use the following kinds of locks/keys:
- Simple Keys, which unlock Simple Doors and Wooden Doors
- Boss Keys, which unlock Boss Doors
- Bombs, which unlock Bombable Walls and Wooden Doors
- New Abilities, which unlock New Ability Locks

----

## Task 1: Lock&Key Puzzles

This task is about lock-and-key puzzles. In short, these are kinds of puzzles where players have to collect keys (which can be literal key items or more abstract things like abilities) to unlock and progress to other areas. Zelda dungeons are a very typical example for this.

*Miro*:
>This virtual whiteboard chart models a larger dungeon full of lock/key puzzles. In contrast to pix:e's modeling, the symbols on the edges here show you directly what key is needed to unlock the edge.
>
>Identify any potential issues with how locks/keys are distributed in this dungeon. These may include, but are not limited to:
>- missing keys
>- unreachable sections
>- soft-locks (i.e. nodes where players may or may not be able to proceed)

*pix:e*:
>You already saw how locks and keys can be modeled in PxCharts. In addition, you can use pix:e to try and find paths in a chart that collect any required keys before passing a locked edge. Simply select the start node of the path by clicking on it and select the end node of the path with Ctrl+Click. If there is a valid path between them, it will be highlighted in purple. If not, the start/end node and any edges that can't be unlocked will be highlighted in red. 
>
>After familiarizing yourself with the functionality, use the PxChart and the built-in pathfinding functionality to identify any potential issues with how locks/keys are distributed in this dungeon. These may include, but are not limited to:
>- missing keys
>- unreachable sections
>- soft-locks (i.e. nodes where players may or may not be able to proceed, highlighted in blue)

## Task 2: Enemy Distribution

This task is about analyzing and comparing different sections of gameplay. This time, the focus lies on two related aspects of gameplay design:
- the number of enemies in a room
- the time it takes to beat all enemies in a room (= complete the room)

Each dungeon can be broken down into 3 sections:
- **section A**: from the first room (marked "START") to the room where players receive a New Ability
- **section B**: from the room with a New Ability to the room with the Boss Key
- **section C**: from the room with the Boss Key to the room with the Boss Fight (marked "BOSS")

*Miro*:
>Use this virtual whiteboard chart to answer the following questions. Make sure to consider locks and keys when looking for the paths!

*pix:e*:
>For this task, you can use the diagrams functionality built into pix:e. Click on the '+' button in the lower left corner of the chart -- this creates a new diagram. Now select one or more numerical component as 'f(x)' to visualize them across all nodes. You can also visualize them along a specific path using the pathfinding functionality you saw in the previous task: Once a path is calculated/reset, pix:e automatically updates the diagram accordingly.
>
>After familiarizing yourself with the functionality, use the PxChart and the built-in diagrams to answer the following questions:

1. Is the number of enemies steadily increasing throughout the dungeon? -> Yes/No
2. Does it take longer on average to complete rooms in section A than section B? -> Yes/No
3. Are there more enemies in section C than in section B? -> Yes/No
4. Which of the rooms most likely contains a miniboss? -> Room number
