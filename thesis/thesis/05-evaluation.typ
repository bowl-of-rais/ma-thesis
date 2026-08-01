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

- user study. this section described design/setup and results.

== User Study Design

=== Overall Setup

- joint user study/team effort. first part of study was concerned with usability, participants asked to model zelda dungeon in tool (including locks & keys) -> participants were already familiarized with context and basic functions of the tool when approaching the tasks described here. task-specific functionalities (pathfinding + solvability-related highlightings, diagrams) were shown to participants prior to respective tasks.
- task-based within-subject: StatePx vs Miro
  - two task variants, varying order of tools + dungeons -> 4 groups:

#figure(
    table(
    columns: (auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header(
        [], [*Miro first*], [*StatePx first*],
    ),
    [*Variant A first*],
    [MA],
    [PA],
    [*Variant B first*],
    [MB],
    [PB],
    ),
    caption: "Definition of the 4 user study participant groups"
)

- use case: zelda dungeons #cite(<summervilleVGLCVideoGame2016>) -> ensure realistic tasks. data pool big enough to choose 2 comparable dungeons per task. same game: consistency in terms of details like item/key types, dungeon structure, etc. dataset provides graphs for each level and full layout/map of dungeons.
- target demographic: people with some understanding of game design -> recruitment: university lecture in games engineering study course, also computer science students who are familiar with videogames
- complete tasks (all dungeons) + answer keys in appendix #todo("add to appendix")

=== Modeling Zelda Dungeons

==== General Modeling

- rooms numbered based on location in map (approx from bottom left to top right)
- some rooms spanned multiple screens and were split (e.g. 9-1, 9-2, 9-3) to more accurately reflect pacing (e.g. enemies that are technically in the same room but do not spawn/become visible and defeatable until the respective screen/part of room is entered)

#todo("image showing room numbering")

==== pix:e vs Miro

pix:e: rooms: node. use in-built functionalities for keys/items and other room data (components). visualization: as described previously

Miro: rooms: sticky notes. write all information into sticky notes. heavier use of emoji encoding: to more easily differentiate between different key types/lock types

comparison: pix:e has more dedicated functionality + logic, but ui is less mature (zoomed out view, editing features). emoji encoding in Miro.

=== Solvability Tasks

- larger Zelda dungeons
- Link's Awakening LA_3, LA_4 #cite(<summervilleVGLCVideoGame2016>)
- selection criteria: size -> non-trivial while still being feasible manually in Miro. comparable size (35 vs 41 nodes) + complexity (outgoing ranks of nodes), similar number of keys/locks. #todo("add details")

#todo("images: original maps/graphs, versions in Miro/pix:e")

- slight adaptations: #todo("add adaptations")
  - structural: #todo("add structural adaptations")
  - information: remove puzzles, "vision" edges, enemies

- added issues: 6 for each dungeon, of varying difficulty
  - 2x missing key(s), 1x no outgoing edge, 1x unreachable due to edge directionality, 2x softlock

- task: find as many issues -> specified kinds of issues
- participants were allowed to use tool functionalities
    - Miro: e.g. draw in paths, use pens/sticky notes to mark found issues
    - pix:e: pathfinding functionality w/ highlighting, fixing issues after reporting

=== Pacing Analysis Tasks

- smaller Zelda dungeons
- Link's Awakening LA_1, LA_2 #cite(<summervilleVGLCVideoGame2016>)
- selection criteria: size, number of keys/locks. comparable size + complexity #todo("add details")

#todo("images: original maps/graphs, versions in Miro/pix:e")

- adaptations: #todo("add adaptations")
  - structural: #todo("add structural adaptations")
  - information: remove puzzles, "vision" edges
  - additional information: completion time and enemy count based on YouTube walkthrough (100% completion to get data for all rooms) #todo("add ref to walkthroughs").

- task: answer questions about pacing. includes comparisons of path sections, overall enemy distribution in nodes:

1. Is the number of enemies steadily increasing throughout the dungeon?
2. Does it take longer on average to complete rooms in Section A than in Section B?
3. Are there more enemies in Section C than in Section B?
4. Which room most likely contains a miniboss?
5. Between which two consecutive rooms does the number increase the most?
6. Which room after a high-intensity encounter has notably fewer enemies or lower completion time? 

- participants were allowed to use tool functionalities
    - Miro: e.g. draw in paths, use pens/sticky notes to note down calculations and answers
    - pix:e: pathfinding functionality w/ highlighting, diagrams

=== Collected Data and Processing

- demographics: age, gender, background, occupation experience, previous experience with whiteboard tools. collected via Google Forms

#todo("add complete demographics")

- recorded during tasks: issues found/questions answered + timestamps, comments, clarifications/hints, observations about tool use
  - semi-structured live protocol, written in Markdown with YAML frontmatter for participant data (id, group)
- separate pix:e accounts/miro boards for participants -> edits

- additionally: UEQ-S #cite(<schreppDesignEvaluationShort2017>) (short version recommended for evaluations of multiple versions of a system), questionnaire comparing Miro and StatePx. collected via Google Forms

#todo("disclaimer: questionnaires team effort")

post-processing:
- manual tagging of task meta data per participant and task: total counts/points based on protocol. parsing script to transform into csv
- codification of google form free-form answers (whiteboard experience, education, occupation)

-> different sets of data

== User Study Results

=== Participants

- total number: 24
- demographics:
  - ages 19-32, average 23.625
  - #todo("educational/occupational background")
  - 15 indicated previous experience with Whiteboard tools (62.5%)
- group breakdown?

=== Results Solvability

#todo("add disclaimer human error")
#todo("add graphs/numbers")
#todo("compare A/B groups and orderings")

==== Data Processing

- spoken answers recorded in protocol -> manual count of total identified issues, manual check against answer key and count of true positives
- inspection of miro boards -> modifications to boards and if so, which ones

==== Task Completion

- total number of identified issues: overall less issues claimed in pix:e, both across all participants as well as within participants. difference is statistically significant (according to Wilcoxon signed-rank test #todo("add numbers") #todo("effect size?"))
- correctly identified issues (f1): significantly lower in pix:e overall, again both across and within participants (according to Wilcoxon signed-rank test #todo("add numbers") #todo("effect size?")).
- in pixie: more issues claimed by people with whiteboard experience. median 1 for participants without whiteboard experience, 2 for participants with whiteboard experience, Mann-Whitney $U = 96.5$, $p < 0.05$. #todo("effect size")
- different distribution (wider?) in difference in number of identified issues between tools in participants with whiteboard experience #todo("specify")
- higher diff/pix:e F1 in people with whiteboard experience. F1 medians 0.25 and 0.285, Mann-Whitney $U = 99.5$, $p < 0.05$
- control for actual usage of Miro functionality (6 participants): no obvious difference #todo("back this up") in task completion in Miro depending on tool use
- possible explanation: tool better suited for power users (extrapolated: people familiar with tool-supported game design). in line with feedback regarding the tool having a learning curve -> may be easier to use when building on pre-existing knowledge. but also good, incentive for Miro users to switch

==== Recorded Times

- #todo("times to first identified issues")

=== Results Pacing

#todo("add disclaimer human error")
#todo("add graphs/numbers")
#todo("compare A/B groups and orderings")

==== Data Processing

analogous to solvability task:
- spoken answers recorded in protocol -> manual count of total answered questions, manual check against answer key and count of correct answers.
- inspection of miro boards -> modifications to boards and if so, which ones

==== Task Completion

- total number of answered questions: median of number of answered questions higher for pix:e, even though distribution skews higher for miro. within participants: median same, but 25th percentile skews a bit lower. participants with whiteboard experience tended to answer more questions in pix:e, while participants without whiteboard experience tended to answer less questions in pix:e. #todo("check statistical significance")
- correctly answered questions (f1): similar trend as total number of answered questions, median higher in pix:e, but distribution skews higher for miro. median of number of correctly answered questions higher in pix:e than miro for participants with whiteboard experience, while for people without whiteboard experience the median is the same, but the distribution skews lower overall.
- control for usage of Miro functionalities (6 participants): participants using functionality in Miro gave fewer total answers, but also fewer wrong answers in Miro version of the task. also, participants using Miro functionality gave more + more correct answers in pix:ie than in miro. #todo("check statistical significance")
//- wrongly answered questions:

==== Recorded Times

- #todo("time per question")

=== Results UEQ-S

- using provided analysis tool based on benchmark for the UEQ-S #cite(<hinderksBenchmarkShortVersion2018>) #todo("what is the benchmark?")
- 8 items divided into 2 categories: pragmatic quality ("relate to the tasks or goals the user aims to reach") and hedonic quality ("related to pleasure or fun while using the product"). overall scale ranges from -3 to 3. 

#figure(
  image("assets/05/ueq-mean-value-per-item.png"),
  caption: "Mean values per item in the UEQ-S"
)

- weakest item: confusing vs clear
  - potentially relates to: UI quirks, lock visualization

- pragmatic quality: mean 0.823 (-> below average, i.e. better than 25% of benchmark), hedonic quality: mean 1.385 (-> good, i.e. better than 75% of benchmark), overall: mean 1.104 (-> above average, i.e. better than 50% of benchmark)

#figure(
  image("assets/05/ueq-against-benchmark.png"),
  caption: "Comparison of UEQ-S scores against benchmark"
)

#todo("control for whiteboard experience?")

=== Results Comparative Questions

- C-Q1: "Compared to Miro, the system made it easier to analyze dungeon designs. "
- C-Q2: "Compared to Miro, I felt more confident in my answers. "
- C-Q3: "Compared to Miro, I was able to complete the tasks more efficiently. "
- C-Q4: "If I were analyzing game levels in practice, I would prefer using the system over a general-purpose whiteboard."

5-point Likert scale, fully disagree (1) to fully agree (5)

#figure(
  image("assets/05/comparative-questions-histogram.png"),
  caption: "Answer distributions for system preference questions, across all participants"
)

- overall, participants indicated preference for statepx over miro, mixed answers with a slight preference for pixie in first three questions
- in line with high hedonic quality reported in UEQ-S

- previous whiteboard experience correlated with lower scores in first three questions #todo("back this up with calculation, significance?"), even though task answers suggest otherwise. for last question, participants with previous whiteboard experience indicated stronger preference for pix:e #todo("back this up"). in line with high hedonic quality. might be because "power users" are better equipped to recognize advantage of tool compared to whiteboard tools.

=== Written Feedback from Participants

- context: once after first part of user study (not described here #todo("add to appendix + reference?")), once at very end of study
- see complete (relevant) freeform answers in @app_us_data

==== Usability/UI

- issues/confusion when adding locks (5x) due to menu placement
- addition of keys not included in right-click menu of nodes (2x)
- low contrast between background and nodes (6x)

==== Functionality

- locks not visually distinguishable (6x)
- confusion about diagram tick labels
- sum/average in diagrams, more interactivity in general

=== Observed Behavior and Verbal Feedback from Participants

- all protocol data, thus may contain human error
- contains: verbal comments/questions while completing the tasks, specific approaches to tool use, verbal feedback

- 5 participants required clarification that all locks were visualized by the same symbol (4 of them completed the task in Miro first, thus may have been primed to expect similar visualization)
- 10 participants did some form of successive pathfinding in pix:e
- 3 participants (all Miro-first groups) asked whether enemies respawn for the pacing task. while unclear in task description, still notable that only Miro-first participants asked this. setup in pix:e may have primed participants to understand the respawn implicitly and apply the same principle in Miro. -> potential improvement for diagrams setup, users should be prevented from making/falling victim to implicit assumptions!

=== Validity of A/B Test

- compare results across groups -> statistical test? (ANIVA for 3+ groups)
- compare demographics across groups

== Limitations

- data collection: human errors
- not all functionality included (e.g. soft gates)

== Post-Study Improvements

- based on feedback/observations

=== Improved Visual Representation of Locks & Keys

- initial version: all locks on edges represented by same symbol respectively. high number of participants feedbacked that distinct visualization of different lock types would improve the experience, or expressed/showed confusion due to the initial representation.

- addition to data model: `symbol` for both locks and keys, can be selected in picker when creating definitions.
    - key assignments show symbol in preview, tooltip shows name of definition on hover
    - edges show symbols of all assigned locks as label. tooltip more involved in current framework. instead: legend popover
- legend: bottom right corner of chart. can be shown/hidden via button. shows overview of available lock + key definitions in separate tabs, including most important informations for users (e.g. symbol, name, for keys: consumability, for locks: unlocking key definitions)

#todo("add screenshots")

=== Reachability Analysis

- many participants (number) either explicitly reported missing a reachability analysis functionality in open feedback or were observed to conduct a reachability analysis during the solvability task by selecting various end nodes for the given start node and subsequently identifying locked edges as those between a node reachable from the start and a node not reachable from the start (10 participants). #todo("add numbers")

- dijkstra algorithm tracks distances of nodes from start nodes. initial value: `Infinity`, i.e., all nodes with distance < `Infinity` are reachable. -> simply filter after pathfinding has concluded

- in case of failed pathfinding: highlight unreachable nodes #todo("confirm/wait for julians pr feedback")

#todo("add screenshots")

=== Increased Contrast of Nodes Against Background

- high number of participants reported low contrast between nodes and background as a usability issue, especially when zoomed out #todo("add numbers")
- new color in css theme for background for both dark and light mode

#todo("add screenshots")


#load-bib()