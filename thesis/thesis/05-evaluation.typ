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

== Methodology

=== High-Level User Study Design

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

- target demographic: people with some understanding of game design -> recruitment: university lecture in games engineering study course, also computer science students who are familiar with videogames
- complete tasks (all dungeons) + answer keys in appendix #todo("add to appendix")

=== Zelda Dungeons from the VGLC dataset

- use case: zelda dungeons #cite(<summervilleVGLCVideoGame2016>) -> ensure realistic tasks. data pool big enough to choose 2 comparable dungeons per task. same game: consistency in terms of details like item/key types, dungeon structure, etc.
- choice: Link's Awakening #todo("add reasoning")
- dataset provides graphs for each level and full layout/map of dungeons. graphs are annotated with game-specific concepts. relevant here: locks/keys, presence of enemies, start/boss/end (triforce) rooms.

#todo("describe data further")

=== Modeling Zelda Dungeons

==== General Modeling

- rooms numbered based on location in map (approx from bottom left to top right)
- some rooms spanned multiple screens (see @multiscreen-example) and were split/modeled with multiple nodes (see @multiscreen-node-numbers) to more accurately reflect pacing (e.g. enemies that are technically in the same room but do not spawn/become visible and defeatable until the respective screen/part of room is entered)

#grid(
  columns: 2,
  grid.cell([
    #figure(
      image("assets/05/multiscreen-room-example-la2.png", width: 90%),
      caption: [Example of multi-screen room in level LA_2 #cite(<summervilleVGLCVideoGame2016>)]
    ) <multiscreen-example>
  ]),
  grid.cell([
    #figure(
      image("assets/05/multiscreen-numbering-example-miro.png", width: 90%),
      caption: "Corresponding node numbering"
    ) <multiscreen-node-numbers>
  ])
)

==== pix:e vs Miro

pix:e: rooms: node. use in-built functionalities for keys/items and other room data (components). visualization: as described previously

Miro: rooms: sticky notes. write all information into sticky notes. heavier use of emoji encoding: to more easily differentiate between different key types/lock types + sticky note with legend

#figure(
  image("assets/05/miro-legend.png", width: 40%),
  caption: "Legend provided with on the Miro task boards"
)

comparison: pix:e has more dedicated functionality + logic, but ui is less mature (zoomed out view, editing features). emoji encoding in Miro.

=== Solvability Tasks

- larger Zelda dungeons
- Link's Awakening LA_3, LA_4 #cite(<summervilleVGLCVideoGame2016>)
- selection criteria: size -> non-trivial while still being feasible manually in Miro. also not so big as to negatively impact performance in pix:e too much and be handleable in zoomed-out view. (75th percentile in VGLC Zelda data)
- subsequent levels from the same game -> comparable size + complexity (outgoing ranks of nodes), similar number of keys/locks, see @solvability-dungeon-numbers.

#figure(
  table(
    columns: (auto, auto, auto, auto, auto, auto),
    inset: 7pt,
    align: horizon,
    table.header(
      [*Level*], [*Nodes*], [*Edges*], [*Locks*], [*Keys*], [*Avg Outgoing Edges*]
    ),
    [LA_3], [41], [83], [26], [11], [2.02],
    [LA_4], [35], [70], [24], [8], [2.0]
  ),
  caption: "Complexity of selected dungeon graphs for solvability tasks, calculated from VGLC data"
) <solvability-dungeon-numbers>

- slight adaptations: #todo("add adaptations")
  - structural: #todo("add structural adaptations")
  - information: remove puzzles, "vision" edges, enemies
  - added 4 nodes, 3 edges, 4 keys to LA_4 to make it more similar in size to LA_3

- added issues: 6 for each dungeon, of varying difficulty
  - 2x missing key(s), 1x no outgoing edge, 1x unreachable due to edge directionality, 2x softlock

- see @la3-vglc and @la3-miro for an impression of the original dungeon layout and adapted version (with issues) in Miro for LA_3. for full-size images and pix:e versions see @app-s-dungeons.

#grid(
  columns: 2,
  inset: 5pt,
  grid.cell([
    #figure(
      image("assets/05/la3-vglc.png"),
      caption: [Annotated screen captures of LA_3 from the VLGC #cite(<summervilleVGLCVideoGame2016>)]
    ) <la3-vglc>
  ]),
  grid.cell([
    #figure(
      image("assets/05/la3-miro.png", width: 80%),
      caption: "LA_3 representation in Miro"
    ) <la3-miro>
  ])
)

- task: find as many issues -> specified kinds of issues
- participants were allowed to use tool functionalities
    - Miro: e.g. draw in paths, use pens/sticky notes to mark found issues
    - pix:e: pathfinding functionality w/ highlighting, fixing issues after reporting

=== Pacing Analysis Tasks

- smaller Zelda dungeons
- Link's Awakening LA_1, LA_2 #cite(<summervilleVGLCVideoGame2016>)
- selection criteria: smaller than dungeons for previous task (to account for additional task complexity due to calculations). (25th percentile in VGLC Zelda data)
- again, subsequent levels comparable size, number of keys/locks/complexity comparable size + complexity, see @pacing-dungeon-numbers.

#figure(
  table(
    columns: (auto, auto, auto, auto, auto, auto),
    inset: 7pt,
    align: horizon,
    table.header(
      [*Level*], [*Nodes*], [*Edges*], [*Locks*], [*Keys*], [*Avg Outgoing Edges*], [*Nodes with Enemies*]
    ),
    [LA_1], [21], [41], [12], [5], [1.96], [12],
    [LA_2], [27], [55], [18], [9], [2.04], [18]
  ),
  caption: "Complexity of selected dungeon graphs for solvability tasks, calculated from VGLC data"
) <pacing-dungeon-numbers>

- additional criterium: little backtracking, clear division into three sections that can be used for comparative analysis of component values along (sub-)paths:
  - A: start to ability
  - B: ability to boss key
  - C: boss key to boss fight

- adaptations: #todo("add adaptations")
  - structural: #todo("add structural adaptations")
  - information: remove puzzles, "vision" edges. locks/keys stay.
  - additional information: completion time and enemy count based on YouTube walkthrough (100% completion to get accurate data for all rooms) #cite(<theretrogamersLegendZeldaLinks2014>), #cite(<theretrogamersLegendZeldaLinks2014a>). enemies that cannot/do not need to be beat are ignored.
- see @la1-vglc and @la1-miro for an impression of the original dungeon layout and Miro representation for LA_1. for full-size images and pix:e versions see @app-p-dungeons.

#grid(
  columns: 2,
  inset: 5pt,
  grid.cell([
    #figure(
      image("assets/05/la1-vglc.png"),
      caption: [Annotated screen captures of LA_1 from the VLGC #cite(<summervilleVGLCVideoGame2016>)]
    ) <la1-vglc>
  ]),
  grid.cell([
    #figure(
      image("assets/05/la1-miro.png", width: 80%),
      caption: "LA_1 representation in Miro"
    ) <la1-miro>
  ])
)

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

- demographics: age, gender, background/education, occupational experience,number of projects/games worked on, previous experience with whiteboard tools and game design tools. collected via Google Forms

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

#todo("compare A/B groups and orderings")

==== Data Processing

- spoken answers recorded in protocol -> manual count of total identified issues, manual check against answer key and count of true positives
- inspection of miro boards -> modifications to boards and if so, which ones

#todo("add disclaimer human error")

==== Task Completion

- total number of identified issues: overall less issues claimed in pix:e, both across all participants as well as within participants, see @fig:s_total. difference is statistically significant (according to Wilcoxon signed-rank test, $T = 48.5$, $p = 0.00564929988211376$, #todo("effect size?"))
- correctly identified issues (f1): significantly lower in pix:e overall, again both across and within participants (according to Wilcoxon signed-rank test, $T = 34.0$, $p = 0.0009066055498154164$ #todo("effect size?")), see @fig:s_f1.

#grid(
    columns: 2,
    inset: (x: 5pt, y: 5pt),
    grid.cell([#figure(
        image("assets/05/solvability-total-boxplot.png"),
        caption: "Distribution of total number of identified issues by tool"
    ) <fig:s_total> ]),
    grid.cell([#figure(
        image("assets/05/solvability-f1-boxplot.png"),
        caption: "Distribution of F1 scores by tool"
    ) <fig:s_f1> ])
)

- in pixie: more issues claimed by people with whiteboard experience, see @fig:s_total_by_wb_exp. median 1 for participants without whiteboard experience, 2 for participants with whiteboard experience, Mann-Whitney $U = 96.5$, $p < 0.05$. #todo("effect size"). however, participants with whiteboard experience still identified significantly fewer issues in pixie than in Miro (Wilcoxon signed-rank test, $T = 97.5$, $p < 0.05$)
- significantly higher pix:e F1 in people with whiteboard experience, see @fig:s_f1_by_wb_exp. F1 medians 0.25 and 0.285, Mann-Whitney $U = 99.5$, $p < 0.05$ #todo("effect size?")

#grid(
    columns: 2,
    inset: (x: 5pt, y: 5pt),
    grid.cell([#figure(
        image("assets/05/solvability-total-by-wb-exp.png"),
        caption: "Distribution of total number of identified issues by tool and indicated whiteboard tool experience"
    ) <fig:s_total_by_wb_exp>]),
    grid.cell([#figure(
        image("assets/05/solvability-f1-by-wb-exp.png"),
        caption: "Distribution of F1 scores by tool and indicated whiteboard tool experience"
    ) <fig:s_f1_by_wb_exp> ])
)

- control for actual usage of Miro functionality (6 participants): 3x marking issues, 1x drawing reachability, 2x inventory tracking
- no obvious difference in task completion in Miro depending on tool use, see @fig:s_total_by_miro_usage and @fig:s_f1_by_miro_usage. total issues identified: median 2 without Miro usage, 2.5 with Miro usage, Mann-Whitney $U = 57.5$, $p=0.4169872469244896$ #todo("effect size?"). F1: median 0.5 with Miro usage, 0.39285714285714285 without Miro usage, Mann-Whitney $U = 57.5$, $p=0.4169872469244896$ #todo("effect size?")

#grid(
    columns: 2,
    inset: (x: 5pt, y: 5pt),
    grid.cell([#figure(
        image("assets/05/solvability-total-by-miro-usage.png"),
        caption: "Distribution of total number of identified issues by tool and use of Miro functionalities"
    ) <fig:s_total_by_miro_usage> ]),
    grid.cell([#figure(
        image("assets/05/solvability-f1-by-miro-usage.png"),
        caption: "Distribution of F1 scores by tool and use of Miro functionalities"
    ) <fig:s_f1_by_miro_usage> ])
)

- overall lower task completion and answer quality in pix:e than Miro. within pix:e, participants with whiteboard experience achieved better results than participants without. within Miro, participants using Miro functionalities did not achieve better results than participants not using Miro functionalities.
- possible explanation/interpretation: similar to first task. pix:e caters better to power users. Miro functionalities (without involved custom setup/templating) seem to be less suited to support users with this specific analytical task type.
- #todo("reference feedback")

==== Recorded Times

- #todo("times to first identified issues")

=== Results Pacing

#todo("add disclaimer human error")
#todo("effect sizes")
#todo("compare A/B groups and orderings")

==== Data Processing

analogous to solvability task:
- spoken answers recorded in protocol -> manual count of total answered questions, manual check against answer key and count of correct answers.
- inspection of miro boards -> modifications to boards and if so, which ones

==== Task Completion

- total number of answered questions: no indication of significant difference in distributions according to Wilcoxon signed-rank test ($T = 96.5$, $p=0.7473513186644183$).
//median of number of answered questions higher for pix:e, even though distribution skews higher for miro. within participants: median same, but 25th percentile skews a bit lower.
- correctly answered questions: also no indication of significant difference in distributions. Wilcoxon signed-rank test: $T=98.5$, $p=0.8058983773663436$
- slight trend: median higher in pix:e, but distribution skews higher for miro.

#grid(
    columns: 3,
    inset: (x: 5pt, y: 5pt),
    grid.cell([#figure(
        image("assets/05/pacing-total.png"),
        caption: "Distribution of total number of answered questions by tool"
    ) <fig:p_total> ]),
    grid.cell([#figure(
        image("assets/05/pacing-right.png"),
        caption: "Distribution of number of correctly answered questions by tool"
    ) <fig:p_right> ]),
    /*
    grid.cell([#figure(
        image("assets/05/pacing-wrong.png"),
        caption: "Distribution of number of wrongly answered questions by tool"
    ) <fig:p_wrong> ])
    */
)

- within pix:e, participants with whiteboard experience tended to answer significantly more questions (see @fig:p_total_by_wb_exp): median 4 with whiteboard experience, 3 without whiteboard experience, Mann-Whitney $U = 103.5$, $p = 0.015198521622538362)$. they also gave significantly more correct answers (see @fig:p_right_by_wb_exp): median 3 with whiteboard experience, 2 without, Mann-Whitney $U = 103.0$, $p=0.01660439188879628)$
- slight skews in median/distribution: number of answered questions higher in pix:e than miro for participants with whiteboard experience, total number and number of correct answers lower in pix:e than Miro for people without whiteboard experience. however, differences in distribution do not seem to be statistically significant (Wilcoxon signed-rank test: $38.0, 0.325888948764388$ for total answers in pix:e vs Miro from participants with Whiteboard experience, $(15.0, 0.20703125)$ for total answers from participants without whiteboard experience)

#grid(
    columns: 3,
    inset: (x: 5pt, y: 5pt),
    grid.cell([#figure(
        image("assets/05/pacing-total-by-wb-exp.png"),
        caption: "Distribution of total number of answered questions by tool and indicated whiteboard tool experience"
    ) <fig:p_total_by_wb_exp> ]),
    grid.cell([#figure(
        image("assets/05/pacing-right-by-wb-exp.png"),
        caption: "Distribution of number of correctly answered questions by tool and indicated whiteboard tool experience"
    ) <fig:p_right_by_wb_exp> ]),
    /*
    grid.cell([#figure(
        image("assets/05/pacing-wrong-by-wb-exp.png"),
        caption: "Distribution of number of wrongly answered questions by tool and indicated whiteboard tool experience"
    ) <fig:p_wrong> ])
    */
)

- control for usage of Miro functionalities (6 participants): 1x sticky note color change to highlight a node/room, 4x calculations in textbox/sticky note/via pen, 1x recording path in textbox
- median of total answered questions and correctly answered questions in Miro lower for participants using functionality in Miro (see @fig:p_total_by_miro_usage and @fig:p_right_by_miro_usage), but not significantly so (Mann-Whitney test: $U = 32.5$, $p=0.07540184146884174$ for total answers, $U = 33.5$, $p=0.08497339144083382$ for correct answers).
- also, median for total number of answered questions and number of correctly answered questions larger in pix:e than miro for participants using Miro functionality, but not statistically significant (Wilcoxon signed-rank test: $T = 11.0$, $p=0.1875$ for total answers, $T=13.5$, $p=0.296875$ for correct answers)

#grid(
    columns: 3,
    inset: (x: 5pt, y: 5pt),
    grid.cell([#figure(
        image("assets/05/pacing-total-by-miro-usage.png"),
        caption: "Distribution of total number of answered questions by tool and use of Miro functionalities"
    ) <fig:p_total_by_miro_usage> ]),
    grid.cell([#figure(
        image("assets/05/pacing-right-by-miro-usage.png"),
        caption: "Distribution of number of correctly answered questions by tool and use of Miro functionalities"
    ) <fig:p_right_by_miro_usage> ]),
    /*
    grid.cell([#figure(
        image("assets/05/pacing-wrong-by-miro-usage.png"),
        caption: "Distribution of number of wrongly answered questions by tool and use of Miro functionalities"
    ) <fig:p_wrong> ])
    */
)

- overall, no significant difference in task completion and answer quality between tools. within pix:e, participants with whiteboard experience achieved better results than participants without. within Miro, participants using Miro functionalities did not achieve better results than participants not using Miro functionalities. 
- possible explanation/interpretation: similar to first task. pix:e caters better to power users. Miro functionalities (without involved custom setup/templating) seem to be less suited to support users with this specific analytical task type.

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

- higher score variance/split observed in participants with whiteboard tool experience in the first three questions, see @app_cq_by_wb_exp. for last question, participants with previous whiteboard experience in particular indicated strong preference for pix:e #todo("back this up"). in line with high hedonic quality. might be because "power users" are better equipped to recognize advantage of tool compared to whiteboard tools.

=== Written Feedback from Participants <feedback_written>

- context: once after first part of user study (not described here #todo("add to appendix + reference?")), once at very end of study
- see complete (relevant) freeform answers in Appendix @app_written_feedback

==== Usability/UI

- issues/confusion when adding locks (5x) due to menu placement
- addition of keys not included in right-click menu of nodes (2x)
- low contrast between background and nodes (6x)

==== Functionality

- locks not visually distinguishable (6x)
- confusion about diagram tick labels
- sum/average in diagrams, more interactivity in general
- unclear highlighting in pathfinding (2x)

=== Observed Behavior and Verbal Feedback from Participants <observed_verbal>

- all protocol data, thus may contain human error
- contains: verbal comments/questions while completing the tasks, specific approaches to tool use, verbal feedback

- 5 participants required clarification that all locks were visualized by the same symbol (4 of them completed the task in Miro first, thus may have been primed to expect similar visualization)
- 10 participants did some form of successive pathfinding in pix:e
- 3 participants (all Miro-first groups) asked whether enemies respawn for the pacing task. while unclear in task description, still notable that only Miro-first participants asked this. setup in pix:e may have primed participants to understand the respawn implicitly and apply the same principle in Miro. -> potential improvement for diagrams setup, users should be prevented from making/falling victim to implicit assumptions!

=== Validity of A/B Test

- compare results across groups -> statistical test? (ANOVA for 3+ groups)
- compare demographics across groups

== Limitations

- data collection: human errors
- not all functionality included (e.g. soft gates, creation of component/lock/key definitions, broder functionalities of pix:e)

== Post-Study Improvements

- based on feedback/observations

=== Improved Visual Representation of Locks & Keys

- initial version: all locks on edges represented by same symbol respectively. high number of participants feedbacked that distinct visualization of different lock types would improve the experience, or expressed/showed confusion due to the initial representation.

- addition to data model: `symbol` for both locks and keys, can be selected in picker when creating definitions. defaults: 🔒 and 🔑.
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