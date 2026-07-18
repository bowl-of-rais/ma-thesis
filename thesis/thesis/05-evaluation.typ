#import "../utils.typ": todo
#import "../bib.typ": load-bib

#import "@preview/lovelace:0.3.1": *

#show raw.where(block: true): it => block(
  fill: rgb("#eeeeee"),
  //fill: rgb("#c6e2f7"),
  inset: 8pt,
  radius: 4pt,
  width: 100%,
  text(it)
)

= Evaluation <eval>

- user study

== User Study Design

=== Overall Setup

- task-based within-subject: StatePx vs Miro
  - two task variants -> 4 groups
- use case: zelda dungeons #cite(<summervilleVGLCVideoGame2016>) -> ensure realistic tasks. data pool big enough to choose 2 comparable dungeons per task. same game: consistency in terms of details like item/key types, dungeon structure, etc.
- target demographic: people with some understanding of game design -> recruitment: university lecture in games engineering study course, also computer science students who are familiar with videogames

=== Modeling Zelda Dungeons

==== General Modeling

- rooms numbered based on location in map (approx from bottom left to top right)

#todo("image showing room numbering")

==== pix:e vs Miro

pix:e: rooms: node. use in-built functionalities for keys/items and other room data (components). visualization: as described previously

Miro: rooms: sticky notes. write all information into sticky notes. heavier use of emoji encoding: to more easily differentiate between different key types/lock types

comparison: pix:e has more dedicated functionality + logic, but ui is less mature (zoomed out view, editing features). emoji encoding in Miro.

=== Solvability Tasks

- larger Zelda dungeons
- Link's Awakening LA_3, LA_4 #cite(<summervilleVGLCVideoGame2016>)
- selection criteria: size (35 vs 41 nodes), number of keys/locks. comparable size + complexity (outgoing ranks of nodes) #todo("add details")

#todo("images: original maps/graphs, versions in Miro/pix:e")

- slight adaptations: #todo("add adaptations")
  - structural: #todo("add structural adaptations")
  - information: remove puzzles, "vision" edges, enemies

- task: find as many issues -> specified kinds of issues

=== Pacing Analysis Tasks

- smaller Zelda dungeons
- Link's Awakening LA_1, LA_2 #cite(<summervilleVGLCVideoGame2016>)
- selection criteria: size, number of keys/locks. comparable size + complexity #todo("add details")

#todo("images: original maps/graphs, versions in Miro/pix:e")

- adaptations: #todo("add adaptations")
  - structural: #todo("add structural adaptations")
  - information: remove puzzles, "vision" edges
  - additional information: completion time based on YouTube walkthrough (100% completion to get data for all rooms) #todo("add ref to walkthroughs")

- task: answer questions about pacing. includes comparisons of path sections, overall enemy distribution in nodes

=== Collected Data

- demographics: age, gender, background, occupation experience

#todo("add complete demographics")

- recorded during tasks: issues found/questions answered + timestamps, comments, clarifications/hints, observations about tool use

- additionally: UEQ-S #cite(<schreppDesignEvaluationShort2017>), questionnaire comparing Miro and StatePx

== User Study Results

=== Data Processing

#todo("potentially more of a methodology section? check wiki")

- data recorded in semi-structured or format -> parsing script to transform
- different sets of data:
  - demographics
  - task meta data per participant and task: total counts/points - based on protocol, may contain some human error
  - time series per participant and task: timestamp + individual answers, comments, etc - based on protocol, may also contain some human error
  - UEQ-S
  - comparison questionnaire

=== Data Analysis

==== Participants

- total number: 24
- demographics
- group breakdown

==== Results Solvability

- total number of identified issues
- correctly identified issues (f1)
- times to first identified issues

==== Results Pacing

- total number of answered questions
- correctly answered questions (f1)
- wrongly answered questions
- time per question

==== Results UEQ-S

- using provided analysis tool
- pragmatic quality ("relate to the tasks or goals the user aims to reach"): 0.823, hedonic quality ("related to pleasure or fun while using the product"): 1.385, overall: 1.104
- #todo("contextualize")
- weakest item: confusing vs clear
  - potentially relates to: UI quirks, lock visualization

==== Results Comparative Questions

- C-Q1: "Compared to Miro, the system made it easier to analyze dungeon designs. "
- C-Q2: "Compared to Miro, I felt more confident in my answers. "
- C-Q3: "Compared to Miro, I was able to complete the tasks more efficiently. "
- C-Q4: "If I were analyzing game levels in practice, I would prefer using the system over a general-purpose whiteboard."

5-point Likert scale, fully disagree (1) to fully agree (5)

#figure(
  image("assets/05/comparative-questions-histogram.png")
)

- overall, participants indicated preference for statepx over miro, mixed answers with a slight preference for pixie in first three questions
- in line with high hedonic quality reported in UEQ-S

- previous whiteboard experience correlated with lower preference for pix:e #todo("back this up with calculation")


==== Validity of A/B Test

- compare results across groups -> statistical test
- compare demographics across groups

== Limitations


#load-bib()