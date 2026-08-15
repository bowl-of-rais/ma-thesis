#import "../utils.typ": todo
#import "../bib.typ": load-bib

= Background <background>

#todo("introductory sentence")

//== Game Design Tools??
//#todo("")

== Player Experience and Pacing <bg-pep>

The two notions of player experience and pacing are a central foundation of this thesis.

#cite(<wiemeyerPlayerExperience2016>) present player experience as a concept analogous to user experience, but translated to the domain of games. 
According to the authors, the term "denotes the individual and personal experience of playing games" and encompasses elements such as immersion, challenge, and emotion.

In contrast, as articulated by #cite(<geheebPaceMakerPracticalTool2024>), "Pacing describes the rhythm that results from the recurring patterns of rhythmic parameters in time."
Rhythmic parameters may be concretely specified by game designers (= artifact parameters, e.g., enemy strength), or aspects of experience that are influenced by artifact parameters (= experience parameters, e.g., encounter intensity).

The two concepts of player experience and pacing relate to each other as described by #cite(<bagusharisaPacingbasedProceduralDungeon2022>), who "summarize game pacing as the rate flow of activit[ies] in a video game [...] that affect the player's experience".
Pacing thus refers to the way in which impulses on player experience are arranged in time as players progress through a game as visualized in @player-experience-pacing-in-time.

In this context, "time" may refer to event time (i.e., the time as measured within the game's world) or play time (i.e., the time passing in the real world as a player plays the game). #cite(<nitscheMappingTimeVideo2007>)

#figure(
    image("assets/02/player-experience-pacing.drawio.png"),
    caption: "Rhythmic parameters arranged in time influence player experience"
) <player-experience-pacing-in-time>

== PaceMaker

PaceMaker #cite(<geheebPaceMakerPracticalTool2024>) is the predecessor of pix:e's player experience module and a prototype toolkit designed for pacing analysis.

In PaceMaker, the non-linear structure of can be modeled using statecharts #cite(<harelStatechartsVisualFormalism1987>).
Each node in the statechart corresponds to a so-called beat, which in turn represents a structural part of a game, such as a scene or level.
Users can assign a set of pre-defined properties to a beat to specify the experience associated with it.
Specifically, these properties include a name, a description, the narrative/gameplay/overall intensity, the gameplay category, and the expected playtime.
Finally, users can create plots to visualize these properties along a path through the chart, with the y-axis representing either event or play time.

A qualitative study conducted to evaluate PaceMaker identified some limitations, e.g., in terms of usability, participants expressed a definitive interest in PaceMaker's functionalities.

== Lock-and-Key Puzzles <bg-locks-and-keys>

A particular aspect of game design for which analysis functionality is implemented in this thesis is the concept of locks-and-key puzzles.

=== Definition

#cite(<ashmoreQuestGeneratedWorld2007>) define lock-and-key puzzles as follows:
"The puzzle is finding out what is an obstacle, what and where is a key to overcome it, and finally using the key to master the challenge."
They further explain that keys may include rather abstract tokens, such as items or skills.

// Consequently, locks and keys as a may refer to both literal locks and keys, but also a wider range of barriers that require certain items (e.g. weapons) or skills (e.g. double jump) to be passed.

=== Taxonomy for Locks and Keys <bg-lock-key-taxonomy>

#cite(<dormansCyclicGeneration2017>) provides an overview of different characteristics that locks and keys may have.
Four different aspects are described for locks and keys respectively.
The taxonomy is recounted in the following and summarized by @tab:lk-taxonomy.

// #todo("add context on dormans?")
The first property refers to how locks may behave in different ways after they have been unlocked.
They may either "remain unlocked forever (permanent), for a short period of time (temporary), or until it is relocked (reversible)" #cite(<dormansCyclicGeneration2017>), or collapse and become unpassable.

Locks may also have an aspect of directionality.
Dormans denominates locks that only allow passage in one direction as "valves".
In contrast, so-called "asymmetrical" locks may be crossed in either direction after they have been unlocked.

Dormans also mentions that locks may or may not _have_ a solution or key ("A safe lock is guaranteed to have a solution, while an unsafe lock is not.", #cite(<dormansCyclicGeneration2017>)).

On the other hand, Dormans also mentions that locks may or may not _need_ a key:
"Some locks are barriers that might be navigated without a key, but this crossing the barrier might be uncertain or impose a certain risk." #cite(<dormansCyclicGeneration2017>)
In the context of this work, this type of lock will be referred to as a soft-gate.
The term is used for a similar concept in #cite(<GatesLevelDesign2023>) and distinguishes the concept from soft-locks, i.e., abstract states in which progression may or may not be possible. #cite(<mawhorterSoftlockDetectionSuper2021>)

As previously described, keys may or may not be literal keys.
Dormans recognizes this fact by distinguishing between single-purpose ("can only be used to open a lock", #cite(<dormansCyclicGeneration2017>)) and multi-purpose keys.

In terms of how keys relate to locks, they may be particular, i.e., "the only thing that unlocks a particular lock" #cite(<dormansCyclicGeneration2017>), or one of multiple keys that unlock the same lock (nonparticular.)

Analogously to how locks may collapse after use, keys may also be destroyed, or rather consumed, when used to pass a lock. Non-consumable keys are also called persistent. #cite(<dormansCyclicGeneration2017>)

Lastly, keys may be "fixed in place" #cite(<dormansCyclicGeneration2017>).

#figure(
  table(
    columns: 3,
    inset: 10pt,
    align: horizon,
    table.header(
      [], [*Aspect*], [*Options*],
    ),
    // LOCKS
    table.cell(rowspan: 4, [Locks]),
    // 1
    [behavior of lock after unlock],
    [permanent, temporary, reversible, collapsible],
    // 2
    [directionality of locks],
    [valve, symmetrical],
    // 3
    [existance of a key],
    [safe, unsafe],
    // 4
    [necessity of a key],
    [soft-gate],
    // KEYS
    table.cell(rowspan: 4, [Keys]),
    // 1
    [whether keys can be used for other purposes],
    [single-purpose, multi-purpose],
    // 2
    [whether there is more than one key that opens a specific lock],
    [particular, non-particular],
    // 3
    [consumability of a key],
    [consumable, persistent],
    // 4
    [whether keys can be moved],
    [fixed, not fixed],
  ),
  caption: "Taxonomy of locks and keys with different aspects and their possible expressions"
) <tab:lk-taxonomy>

== Web Technology

#todo("tech stack: vue/nuxt/VueFlow in frontend, django in backend. explain what composables and components are")

== Dijkstra's Algorithm

#todo("concise description of the Dijkstra algorithm, supported by relevant sources.")

== Inventory-Based Search Algorithms <bg-inventory-search>

#todo("@Anie: das wird in 4.3 erwähnt, aber idk wie viel ich hier ins detail gehen sollte - eigentlich ist nur das konzept 'inventory' relevant. Vielleicht lieber dort kurz das konzept erklären und inventory-based jump-point search in related works schieben, weil ich ja hier auch eine art inventory-based search algorithm vorstelle?")

#todo("explain concept and what of it is relevant to here, what of it is not")

- inventory-based jump-point search #cite(<aversaPathPlanningInventoryDriven2015>) is grid-based. statechart could be mapped to grid, but would probably be suboptimal because nodes have generally low rank and don't necessarily conform to neighboring structure of a grid. concept of inventory is still relevant, though.

#todo("possibly make connection to petri nets")


#load-bib()