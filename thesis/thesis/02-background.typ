#import "../utils.typ": todo
#import "../bib.typ": load-bib

= Background <background>

== Game Design Tools??

#todo("")

== Player Experience <bg-player-experience>

#cite(<wiemeyerPlayerExperience2016>): similar to user experience, but considers aspects specific to games.

== Statecharts

#todo("add section on statecharts?")

== PaceMaker <bg-pacemaker>

#cite(<geheebPaceMakerPracticalTool2024>)

- PaceMaker: predecessor of PxCharts

"The toolkit, PaceMaker, allows the user to design a non-linear experience chart and subsequently plot relevant information like intensity or gameplay category of each node along a path on the chart."

-> presented as prototype/PoC

"Pacing describes the rhythm that results from the recurring patterns of rhythmic parameters in time. Rhythmic parameters are divided into artifact and experience parameters."

-> mostly numerical or categorical

=== Functionalities and Evaluation of PaceMaker

1. statecharts for modeling #cite(<harelStatechartsVisualFormalism1987>)
	- nodes = beats
2. experience specification: properties that can be assigned to a beat
	- name, description, narrative/gameplay/overall intensity, gameplay category, expected playtime
	- in p:xe: PxComponents, can be defined by user (available datatypes: TODO)

- usability issues
- nesting/concurrency

== Lock-and-Key Puzzles <bg-locks-and-keys>

A particular aspect of game design for which analysis functionality is implemented in this thesis is the concept of locks and keys.

=== Definition

#cite(<ashmoreQuestGeneratedWorld2007>):
"The puzzle is finding out what is an obstacle, what and where is a key to overcome it, and finally using the key to master the challenge."

#cite(<ashmoreQuestGeneratedWorld2007>):
"Obstacles may not be passed until the player obtains some token (such as an item or skill)"

may be literal locks and keys, but may also be other items (e.g. weapons) or skills (e.g. double jump).

#todo("add more content")

=== Taxonomy for Locks and Keys <bg-lock-key-taxonomy>

#cite(<dormansCyclicGeneration2017>) provides an overview of different characteristics that locks and keys may have.

#todo("add context on dormans?")

==== Locks

#cite(<dormansCyclicGeneration2017>):
"When you unlock a door, that door might remain unlocked forever (permanent), for a short period of time (temporary), or until it is relocked (reversible). Sometimes, a lock collapses after use, allowing the player only to pass once."

-> locks: *permanent, temporary, reversible, collapsible*

#cite(<dormansCyclicGeneration2017>):
"Certain locks allow you to cross only in one direction (valves), while others can only be opened from one direction but traversed in two directions after they are opened (asymmetrical). \[...\] Valves do not always require a key.""

-> locks: *valve, asymmetrical*

#cite(<dormansCyclicGeneration2017>):
"A safe lock is guaranteed to have a solution, while an unsafe lock is not."

-> locks: *safe or unsafe*

#cite(<dormansCyclicGeneration2017>):
"Some locks are barriers that might be navigated without a key, but this crossing the barrier might be uncertain or impose a certain risk."

==== Keys

#cite(<dormansCyclicGeneration2017>):
"Single-purpose keys can only be used to open a lock, and for nothing else, while multipurpose keys can also be used in different ways."

-> keys: *single-purpose or multi-purpose*

#cite(<dormansCyclicGeneration2017>):
"Particular keys are the only thing that unlocks a particular lock, whereas several nonparticular keys might unlock a single lock."

-> keys: *particular or non-particular*

#cite(<dormansCyclicGeneration2017>):
"Keys that are destroyed somehow in the process of unlocking a door are consumable, while keys that are not are persistent."

-> keys: *consumable or persistent*

#cite(<dormansCyclicGeneration2017>):
"Levers and switches are the best example of keys that are fixed in place (and typically single purpose and particular as well)."

-> keys: *fixed or not*

== Inventory-Based Search Algorithms <bg-inventory-search>

#todo("explain concept and what of it is relevant to here, what of it is not")

- inventory-based jump-point search #cite(<aversaPathPlanningInventoryDriven2015>) is grid-based. statechart could be mapped to grid, but would probably be suboptimal because nodes have generally low rank and don't necessarily conform to neighboring structure of a grid. concept of inventory is still relevant, though.



#load-bib()