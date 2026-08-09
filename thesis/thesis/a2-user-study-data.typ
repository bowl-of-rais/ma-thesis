#import "../utils.typ": todo
#import "../bib.typ": load-bib

= User Study Data <app-us-data>

== Results of Comparative Questions by Whiteboard Experience <app-cq-by-wb-exp>

The following plots visualize the answer distributions to the four questions comparing Miro to StatePx stratified by indicated whiteboard experience on a shared y-axis.

#figure(
  image("assets/app/c-q1-by-wb-exp.png"),
  caption: "Distribution of answers to C-Q1 by indicated whiteboard tool experience"
)

#figure(
  image("assets/app/c-q2-by-wb-exp.png"),
  caption: "Distribution of answers to C-Q2 by indicated whiteboard tool experience"
)

#figure(
  image("assets/app/c-q3-by-wb-exp.png"),
  caption: "Distribution of answers to C-Q3 by indicated whiteboard tool experience"
)

#figure(
  image("assets/app/c-q4-by-wb-exp.png"),
  caption: "Distribution of answers to C-Q4 by indicated whiteboard tool experience"
)

== Written Feedback <app-written-feedback>

=== After Part 1

After first part of user study: "Was there anything about the modeling interface that you found confusing or frustrating?"
filtered here for comments relevant to work in this thesis (mainly locks & keys)

- I often had to double-click on an object, like a button or an edge, in order to activate it or change its properties.
- I didn't see where I could add locks
- I was to dumb to figure out how to add a key, also the right click context actions could be more consistent
- No multi-select via drop-clicking was frustrating. Also didn't notice lock option on edges until the end. "Key" button for bombs too.
- Adding locks to edges is triggered with a separate menu, which did not pop up by clicking at the edge, having a less natural flow as for the rooms, where edit options where shown in the room box directly.
- The button for adding keys is not in the right-click menu.
- There could be more information e.g. in tooltips
- Sometimes, when adding a new component, the system was showing weird values in their place, taking roughly a second to update. Also, when clicking on an edge, I wanted to know what kind of lock it showed.
- Locks were a bit weird to set up, the two buttons in the top left felt not quite in place. Also some features have right click context menu actions while others don't.

=== After Part 2

After entire user study: "Anything else you want to tell us?"

- The locks need to be differentiable by look
- It's nice to use but it takes some time to get used to imo
- Would have liked to have a "total time needed to reach room n" when selecting a path. Also it was slightly confusing that the diagramme didn't show the rooms on the path in order on its x axis.
- Tool did not make it clear which locks had which type (UI issue). I felt confident answering questions for the "direct" path, but manual intervention would be required to analyze indirect paths. Thus I did not feel confident answering questions in full generality.
- Please for gods sake put more contrast between the nodes/the graphical outline of the nodes and the background it is very difficult to exactly see the nodes which lead to some confusion on my part
- I feel like so much potential is wasted not in the design of the system but the missing polish, div borders disappearing when zoomed out too far, no different visual indicators for walls, locks etc. Also a sum and average funtction would be huge for the pacing analysis
- i wasn't really sure what happened in the path finding when i tried to get from start to finish and no node had a rim and random paths lit up, it does need some time to get used to but i think it could really help upon building dungeons; a few more statistics would be fun to see averages
- I would have liked to be able to interact more with the diagram, e.g. some on specific parts of the x achsis.
- Probably the biggest issue that I had was the readability of it. On Miro the rooms were on a yellow note, having contrast with the background, with only essential information simpled down. On the new system, the rooms are too big and apart from each other, also blending with the background, and the information took more time to read and comprehend
- it's easy to accidentally moving nodes; zooming out looses details such as the borders around the boxes that are the nodes in the graph, instead of being more coarse-grained.
- When getting a path from one node to another, I would like to get more information about the intermediate states the system had on the nodes in between.
- in miro i liked that i could see the number of enemies or the types of doors etc. directly on the node even when zoomed pretty far out. the different components had different icons and colors (because they were emojis) which made it easy to distinguish them. Also the name of the nodes was bigger and the edges were more bold so i could read everything clearly even when zoomed out pretty far. in pix:e i could barely read anything except if i was zooming in a lot which hindered the development of a mental map. Though, the pathfinding tools and diagrams for enemy number and time in pix:e were pretty useful and in miro i was requiring more mental effort to keep track of the enemies and times etc.
- It was way easier to tell the type of a lock in Miro because of the different symbols
- The nodes are hard to distinguish from the background when zooming out because of a low contrast and thin outlines. Otherwise I would've found relevant nodes much faster.
- In its current state the system lacks clear indicators of what exactly is being highlighted/which paths are analyzed ect. - stronger graphical indicators would completely change the experience for me
- More functionality would be nice: Better visual cues (as in the miro board) for different types of doors, etc., cumulative graphs for the function, better readability of the graph (it was not so clear to see graph node A in the function graph anymore when selecting path from A to B to C in task 2)
- The tool definately has great potential, but there are some minor nitpicks which for me made it less usable as miro. If those are fixed im confident it can and will be better

#load-bib()