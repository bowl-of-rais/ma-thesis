#import "../utils.typ": todo
#import "../bib.typ": load-bib

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

= Background <background>

#todo("introductory sentence")

//== Game Design Tools??
//#todo("")

== Player Experience and Pacing <bg-pep>

The two notions of player experience and pacing are a central foundation of this thesis.

#cite(<wiemeyerPlayerExperience2016>) present player experience as a concept analogous to user experience, but translated to the domain of games. 
According to the authors, the term "denotes the individual and personal experience of playing games" and encompasses elements such as immersion, challenge, and emotion.

In contrast, #cite(<geheebPaceMakerPracticalTool2024>) define pacing as "the rhythm that results from the recurring patterns of rhythmic parameters in time."
Rhythmic parameters may be concretely specified by game designers (= artifact parameters, e.g., enemy strength), or aspects of experience that are influenced by artifact parameters (= experience parameters, e.g., encounter intensity).

The two concepts of player experience and pacing relate to each other as described by #cite(<bagusharisaPacingbasedProceduralDungeon2022>), who "summarize game pacing as the rate flow of activit[ies] in a video game [...] that affect the player's experience".
Pacing thus refers to the way in which impulses on player experience are arranged in time as players progress through a game.
This interplay is visualized in @player-experience-pacing-in-time.

In this context, "time" may refer to event time (i.e., the time as measured within the game's world) or play time (i.e., the time passing in the real world as a player plays the game). #cite(<nitscheMappingTimeVideo2007>)

#figure(
    image("assets/02/player-experience-pacing.drawio.png"),
    caption: "Rhythmic parameters arranged in time influence player experience"
) <player-experience-pacing-in-time>

== PaceMaker

PaceMaker #cite(<geheebPaceMakerPracticalTool2024>) is the predecessor of pix:e's player experience module and a prototype toolkit designed for pacing analysis.

In PaceMaker, non-linear structures of game progression can be modeled using statecharts #cite(<harelStatechartsVisualFormalism1987>).
Each node in the statechart corresponds to a so-called beat, which in turn represents a structural part of a game, such as a scene or level.
Users can assign a set of pre-defined properties to a beat to specify the experience associated with it.
Specifically, these properties include a name, a description, the narrative/gameplay/overall intensity, the gameplay category, and the expected playtime.
Finally, users can create plots to visualize these properties along a path through the chart, with the y-axis representing either event or play time.

In a qualitative study conducted to evaluate PaceMaker, participants were found to express a definitive interest in PaceMaker's functionalities.

== Lock-and-Key Puzzles <bg-locks-and-keys>

A particular aspect of game design for which analysis functionality is implemented in this thesis are locks-and-key puzzles.

=== Definition

#cite(<ashmoreQuestGeneratedWorld2007>) define lock-and-key puzzles as follows:
"The puzzle is finding out what is an obstacle, what and where is a key to overcome it, and finally using the key to master the challenge."
They further explain that keys may include rather abstract tokens, such as items or skills.

// Consequently, locks and keys as a may refer to both literal locks and keys, but also a wider range of barriers that require certain items (e.g. weapons) or skills (e.g. double jump) to be passed.

=== Dormans' Taxonomy for Locks and Keys <bg-lock-key-taxonomy>

#cite(<dormansCyclicGeneration2017>) provides an overview of different characteristics that locks and keys may have.
Four different aspects are described for locks and keys respectively.
The rest of this section recounts Dorman's taxonomy and summarizes it in @tab:lk-taxonomy.

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
    [valve, asymmetrical],
    // 3
    [existence of a key],
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

Dijkstra's algorithm #cite(<dijkstraNoteTwoProblems1959>) is a shortest-path algorithm for non-negative weighted graphs.
Its central idea is to iterate over the graph's nodes in ascending order of distance from a given start node.
As the graph is traversed, the node distances are updated.
The node distances are typically managed in a priority queue.
Additionally, the algorithm records the predecessor for each node, from which the shortest path can be constructed.

#pseudocode(
  [```
    dijkstra(start)
    dist = [∞, ..., ∞]              // distances of nodes from start
    prev = [null, ..., null]        // node predecessors
    q = []                          // priority queue
    dist[start] = 0
    q.insert(s)

    while q not empty do
        n = q.pop()
        for each edge e = (n, m) in E do
            if dist(n) + weight(e) < dist(m) then
                dist(m) = dist(n) + weight(e)
                pred(m) = n
                if v not in q then q.insert(v)
                sort q using dist as priority
    
    return dist, prev  
  ```],
  [Dijkstra's algorithm, adapted from #cite(<mehlhornShortestPaths2008>)],
  <dijkstra-pseudo>
)

#load-bib()