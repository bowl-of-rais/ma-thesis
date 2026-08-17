
#set par(first-line-indent: 0em)
#set text(font: "Open Sans", size: 11pt)

#set heading(outlined: false, numbering: none)
#show heading: set text(
  weight: "regular"
)

#show heading.where(level: 2): set text(size: 16pt)
#show heading.where(level: 3): set text(size: 14pt)
#show heading.where(level: 4): set text(size: 12pt)
#show heading.where(level: 5): set text(size: 12pt)


== Introduction

=== Goal of the Study

We are going to evaluate the system “StatePX” and its capabilities. We are not evaluating you personally in any way. The collected data is pseudo-anonymous. It might be possible that tasks are not manageable in the given time frame. Again, this is no evaluation of your skill. The tasks are designed in a way to gauge how far users can get, so they are intentionally extensive.

=== General Introduction

StatePX was developed to model “player experiences”, an experience a player has while playing a game. The experience is modeled with a graph, where a node describes a player experience and edges describe how these experiences are connected. In addition to just modeling the player experience, it can also analyze the graph, show how the progression unfolds, and give insights into solvability, i.e. whether certain areas can be reached and how.

Each task has a maximum time limit. Work as accurately as you normally would. If you finish before the time limit, let the moderator know. Otherwise, the moderator will stop the task once the time limit has been reached. 

==== Task 1 - Building a first graph

In this task, you get familiar with the tool and build a first graph together with relevant components, locks, and keys. Along with this task you can see the final section of a dungeon from Legend of Zelda.

We have already prepared a node for the first room, but it is still missing many details. For all sub-tasks, include all information that is represented accompanying facts of the map. During all tasks, feel free to ask any clarifying questions regarding the tasks.

#h(2em)
===== Task 1a

Complete the node for room 12 by adding all components and all keys.

#h(2em)
===== Task 1b

Complete the graph by adding all nodes, edges, components, locks, and keys for rooms 11, 12, 13, and 14.

#image("task-1b.png")

Clarifying hints: - Edges can be uni- or bi-directional. - Keys and locked doors are marked by boxes 

We just provided you with another section of the dungeon that leads to the final section from task 1. The two parts of the dungeon are connected through staircases in room 4 and room 12. Similar to task 1a, we prepared part of the graph for this dungeon, but it is still missing some nodes, locks, keys and components. 

#h(2em)
===== Task 1c

Complete the graph for the dungeon by adding all nodes, edges, components, locks, and keys for rooms 5, 6, and 7. 

#image("task-1c.png")

=== Gameplay Analysis

In this part of the study, you will use dungeon graphs to analyze different aspects of gameplay design.

You will complete two different analysis tasks using both the tool and a virtual whiteboard (Miro). Depending on the study condition, the order of tools and tasks may differ.

Throughout the tasks, the following progression elements are used:
- Simple Keys unlock Simple Doors and Wooden Doors
- Boss Keys unlock Boss Doors
- Bombs unlock Bombable Walls and Wooden Doors
- Abilities unlock Ability Locks

==== Task 2 - Solvability Analysis

This task focuses on analyzing the solvability of another Zelda dungeon.

During gameplay players collect keys, abilities, and other progression items to unlock new areas of the dungeon. Incorrect placement of these progression elements can make parts of the dungeon unreachable or even impossible to complete.

Your goal is to analyze the given graph and identify any potential solvability issues.

These may include, but are not limited to:

- Missing keys (Simple Key, Boss Key, Bombs, Abilities)
- Unreachable Sections
- Soft-locks (situations where player may or may not be able to continue)
- Hard-locks (situations where the player is not able to continue) 

#h(2em)
===== Miro

This virtual whiteboard models the dungeon as a graph.

The symbols shown on the edges indicate which progression item is required to traverse that connection.

Use the graph to identify any potential solvability issues.

You are allowed to add sticky notes of a different color after identifying and communicating an issue. Also let us know your confidence regarding the issue. 

#h(2em)
===== StatePX

StatePX provides a pathfinding function that can determine whether a valid path exists between rooms.

To calculate a path:

- Click the starting room
- Hold Ctrl and click the destination room
- Wait a moment to let the tool calculate the path
- Repeat Ctrl+Click to add additional destinations and chain multiple paths together.

Use both the graph and the pathfinding functionality to identify any potential solvability issues. 

You are allowed to make modifications to the graph after identifying and communicating an issue. Also let us know your confidence regarding the issue.

A legend describing the visualization colors is provided next to the interface. 

#image("task-2-legend.png")

==== Task 3 - Pacing Analysis

This task focuses on analyzing the pacing of combat encounters throughout the dungeon.

Each room contains information about

- the number of enemies
- the time required to defeat all enemies (room completion time)

The dungeon can be divided into three gameplay sections:

- Section A: from START to the room where the player receives a New Ability
- Section B: from the New Ability room to the room containing the Boss Key
- Section C: from the Boss Key room to the BOSS

Answer the following questions.

1. Is the number of enemies steadily increasing throughout the dungeon?
2. Does it take longer on average to complete rooms in Section A than in Section B?
3. Are there more enemies in Section C than in Section B?
4. Which room most likely contains a miniboss?
5. Between which two consecutive rooms does the number increase the most?
6. Which room after a high-intensity encounter has notably fewer enemies or lower completion time? 

#h(2em)
===== Miro

Use the information shown in the graph to answer the questions.

When reasoning about the dungeon, make sure to consider valid progression paths through the dungeon. 

#h(2em)
===== StatePX

In addition to the pathfinding functionality used in the previous task, StatePX provides diagrams for visualizing numerical information.

To create and use a diagram:

- Click the + button in the lower-left corner.
- Select one or more numerical components as f(x).
- Select a path like before.

The diagram visualizes the selected values across the dungeon graph.

Whenever a path is calculated or reset, the diagram automatically updates to visualize the selected values along that path.

Use the graph, the pathfinding functionality, and the diagrams to answer the questions. 