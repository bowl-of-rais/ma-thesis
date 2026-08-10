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

The implemented functionalities were evaluated via a user study.
This section describes the methodology of the study, including the overall setup and design, and presents its results.

== Methodology

This sub-section first describes the goal and high-level design of the user study.
It then details the chosen use case and task designs and outlines the collected data.

=== Goal

The main questions the user study was intended to answer are whether the implemented analysis functionalities are
1. helpful and
2. interesting.

To assess the helpfulness aspect, participants were given tasks designed to evaluate the impact of the tool on their performance.
The aspect of interest was then captured via questionnaires and additional participant feedback.

=== High-Level User Study Design

The evaluation of the functionalities implemented as part of this work was the second part of a larger study conducted in a joint team effort.
The first part of the study was concerned with assessing the usability of the system.
In particular, participants were asked to model a Zelda dungeon in the tool, including locks and keys.
Consequently, participants were already familiarized with the use case context and basic functions of the tool when approaching the tasks described here.
Task-specific functionalities (e.g., pathfinding and highlighting, as well as the diagrams) were introduced to the participants prior to the respective tasks.

The general setup for this evaluation was a within-subject or repeated measures study, in which participants completed the tasks once in StatePx and once in another tool.
The two task variants necessary for this setup as well as a varying order of tools resulted in the four groups shown in @user-study-groups.

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
) <user-study-groups>

The chosen baseline tool was Miro.
#todo("why miro?")

To restrict the overall time per participant, especially in context of the joint study design, the tasks were designed in such a way that participants were given a set amount of time (5 minutes) for each task variant.

The target demographic was people with some understanding of game design.
Participants were thus mainly recruited in a university lecture from a games engineering study course, though participants also included computer science students with some familiarity with videogames.

The study was conducted exclusively in person.
For details on data collection, see @eval-data-collection.

=== Task Designs

The functionalities were evaluated via two distinct tasks: a "Solvability" task, which targeted the functionalities around locks and keys, and a subsequent "Pacing Analysis" task, which focused on the diagram function.
Splitting the evaluation into two tasks reduced the context required to understand and complete each task and was an intentional choice to limit the amount of new information participants were confronted with at a time.
The "Pacing Analysis" task assumed an understanding of pathfinding including locks and keys and was placed after the "Solvability" task.

For the complete task description including all dungeons and the respective answer keys, see @app-us-design.
#todo("add to appendix")

==== Zelda Dungeons from the VGLC dataset

The use cases chosen for this study were dungeons from the Legend of Zelda video game series.
#todo("reasoning?") -> ensure realistic tasks.
As the use case is concerned with modeling individual dungeons or levels, it corresponds to a low-level modeling approach.
This is more fitting for this particular study as the individual charts are self-contained and sufficiently complex while also being taken from the same context.  

The exact level designs were extracted from the Video Game Level Corpus #cite(<summervilleVGLCVideoGame2016>).
While the dataset provides data from three different Legend of Zelda game, the dungeons for both tasks and all variants were chosen from the same game to ensure consistency in details such as item, lock, or key types and the overall complexity and structure of the dungeons.
The dungeons from the game "The Legend of Zelda: Link's Awakening" were best suited for the evaluation tasks.
#todo("add reasoning, incl two comparable dungeons per task")

Apart from the full level layout and map of each dungeon, the dataset provides level graphs that are annotated with game-specific concepts.
Relevant for the following task designs were the overall graph structure as well as placements of locks, keys (including so-called key items), and enemies, and the locations of start/boss rooms.
The graphs included edges modeling visibility, i.e., if room $B$ could be seen from room $A$, an edge connects the corresponding nodes even if the player cannot reach room $B$ from $A$.
The concept of visibility, including these edges, was not included in the user study tasks.

==== Modeling of Zelda Dungeons

#h(1.8em)
===== General Modeling
As the tasks required participants to refer to individual rooms in the dungeon, they were numbered based on their location in map (approx from bottom left to top right).

Some rooms spanned multiple screens (see @multiscreen-example) and were thus modeled with multiple nodes (see @multiscreen-node-numbers) to more accurately reflect the game's pacing or experience.
For instance, when passing through one portion (one screen) of a room, any enemies that are in another part of said room and do not spawn or become visible and defeatable until that other part of room is entered are not part of that player's experience.

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

#h(1.8em)
===== Modeling Dungeons in pix:e vs Miro
In pix:e, each room was modeled by a node.
Any keys, items, and other room data were modeled by the built-in functionalities.
This resulting visualization is as described previously in @impl-diagrams and @impl-lk.
#todo("refine")

Miro as a general-purpose whiteboard tool offers sticky notes, which can be connected by arrows/lines.
They were thus used to represent the individual nodes.
Node-specific information was simply written into the sticky notes as text, and locks were added as edge labels.
The different lock and key types were encoded as emojis, and an additional sticky note served as a legend (see @miro-legend).
This encoding was used to obtain a visualization that is as clear and straightforward as possible given the available options in Miro.

#figure(
  image("assets/05/miro-legend.png", width: 40%),
  caption: "Legend provided with on the Miro task boards"
) <miro-legend>

==== Solvability Tasks

To evaluate the analysis functionalities concerning solvability, participants were given an unsolvable dungeon (i.e., a dungeon where the boss room is not reachable from the start room) with multiple issues and asked to identify as many issues as possible.
They were introduced to the available lock and key types and the different possible issue types.
Before starting the task in pix:e, participants were also given a demonstration of the pathfinding functionality and a legend for the different highlighting colors.

In both tools participants were allowed to use any tool functionalities.
In Miro, this for instance includes using the pen tool to draw in paths or marking found issues with text or sticky notes.
An example in pix:e apart from the aforementioned pathfinding/highlighting functions would be fixing issues after reporting to perform pathfinding under different conditions.

The dungeons chosen for the two variants of this tasks were the third (LA_3) and fourth (LA_4) dungeons from "Link's Awakening" (LA_3 and LA_4 in #cite(<summervilleVGLCVideoGame2016>)).
Dungeon LA_3 is used in variant A of the task, and dungeon LA_4 is used in variant B.
The main criterion for this choice was the dungeons' size, as they are sufficiently large and thus make the task sufficiently complex while still being feasible manually in Miro.
Their node count is around the 75th percentile across all VGLC Zelda data.
The two dungeons, being subsequent levels from the same game, have comparable size and complexity (based on the outgoing ranks of nodes) and similar numbers of keys/locks (see @solvability-dungeon-numbers).

#figure(
  table(
    columns: (auto, auto, auto, auto, auto, auto),
    inset: 7pt,
    align: horizon,
    table.header(
      [*Level*], [*Nodes*], [*Edges*], [*Locks*], [*Keys*], [*Avg Outgoing Edges*]
    ),
    [*LA_3*], [41], [83], [26], [11], [2.02],
    [*LA_4*], [35], [70], [24], [8], [2.0]
  ),
  caption: "Complexity of selected dungeon graphs for solvability tasks, calculated from VGLC data"
) <solvability-dungeon-numbers>

- slight adaptations: #todo("add adaptations")
  - structural: #todo("add structural adaptations")
The charts included information regarding the locations of locks and keys and indicated start and boss nodes.
Additionally, LA_4 was extended by four nodes, three edges, and four keys to accommodate the size difference between the two dungeons.

To make the dungeons unsolvable, 6 issues of varying difficulty were added in each dungeon.
For both, this included
- two instances of missing key(s), i.e., an edge not being unlockable with the keys a player could have collected on any path from the start node
- one node with no outgoing edge
- one area (group of nodes) that is unreachable due to wrong edge directionality
- two softlocks

See @la3-vglc for an impression of the original dungeon layout and @la3-miro for the adapted version with issues in Miro for LA_3.
Full-size imagess and pix:e versions are included in @app-s-dungeons.

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

==== Pacing Analysis Tasks

To evaluate the diagram functionality, participants were given a dungeon and a set of questions to answer regarding the distribution and changes in component values throughout the dungeon.
Again, participants were introduced to the relevant component types and given a demonstration of the diagrams functionality.

Participants were once again allowed to use any tool functionalities, in particular any text/pen tools in Miro to record a valid path through the dungeon or any calculations.

For this task, the choice fell on smaller dungeons, in particular the first and second dungeons of "Link's Awakening" (LA_1 and LA_2 in #cite(<summervilleVGLCVideoGame2016>)).
Variant A of the task uses LA_1, while variant B uses LA_2.
Size was again a key criterion, though in contrast to the Solvability task, the dungeons for this task were deliberately selected to have a smaller size (25th percentile in VGLC Zelda data).
The intention was to account for expected higher task complexity due to manual pathfinding and calculations in the Miro version.
The two levels are again subsequent levels of comparable size and complexity with similar numbers of locks and keys (see @pacing-dungeon-numbers).

#figure(
  table(
    columns: (auto, auto, auto, auto, auto, auto, auto),
    inset: 7pt,
    align: horizon,
    table.header(
      [*Level*], [*Nodes*], [*Edges*], [*Locks*], [*Keys*], [*Avg Outgoing Edges*], [*Nodes with Enemies*]
    ),
    [*LA_1*], [21], [41], [12], [5], [1.96], [12],
    [*LA_2*], [27], [55], [18], [9], [2.04], [18]
  ),
  caption: "Complexity of selected dungeon graphs for solvability tasks, calculated from VGLC data"
) <pacing-dungeon-numbers>

An additional criterium for this task was a clear division of the critical path into three sections that can be used for comparative analysis of component values along (sub-)paths:
  - A: from the start room to the room where players obtain a new ability
  - B: from the room with a new ability to the room with the boss key
  - C: from the room with the boss key to the boss fight room
A consequence of this aspect is the critical paths containing little backtracking, which is also beneficial as nodes (and thus likely component values) are more distinct between sections.

- adaptations: #todo("add adaptations")
  - structural: #todo("add structural adaptations")
The information provided in the charts included the placement and types locks/keys and, for rooms containing enemies, the enemy count and the time required to beat all enemies.
As the VGLC only includes data on whether rooms contain enemies, the completion time and enemy count were based on YouTube walkthroughs (specifically 100% completion walkthroughs to best approximate accurate data for all rooms) #cite(<theretrogamersLegendZeldaLinks2014>), #cite(<theretrogamersLegendZeldaLinks2014a>).
Enemies that cannot be beat are ignored in the counts.

The questions given to the participants were designed to cover different aspects of pacing and vary in difficulty.
They include comparisons of path sections, the overall distributions throughout the dungeon as well as the relation between the two components:

1. Is the number of enemies steadily increasing throughout the dungeon?
2. Does it take longer on average to complete rooms in Section A than in Section B?
3. Are there more enemies in Section C than in Section B?
4. Which room most likely contains a miniboss?
5. Between which two consecutive rooms does the number increase the most?
6. Which room after a high-intensity encounter has notably fewer enemies or lower completion time? 

See @la1-vglc and @la1-miro for an impression of the original dungeon layout and Miro representation for LA_1.
For full-size images and pix:e versions, see @app-p-dungeons.

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

=== Collected Data and Processing <eval-data-collection>

The data collected as part of the evaluation can be grouped into four categories: demographics, task-related data, post-task questionnaires and additional written feedback.

The collected demographics are comprised of participants' age, gender, educational background, occupational background, number of projects/games worked on, previous experience with whiteboard tools and previous experience with game design tools.
The data was collected via Google Forms.

Task-related data included, for one, participants' direct responses to the tasks, i.e., any issues participants claimed to have found during the solvability task (with timestamps) and any answers to questions during the pacing analysis task (with timestamps).
Additionally, any comments from participants, any clarifications/hints they required and observations about their tool use were logged.
This data was logged in a semi-structured live protocol written in Markdown.
Moreover, as separate pix:e accounts and Miro boards were used for each participant, any modifications to the charts were also recorded.

After completing all tasks, participants were given the UEQ-S #cite(<schreppDesignEvaluationShort2017>) and a short questionnaire comparing Miro and StatePx (see @res-comparative-questions).
Like the demographic data, the reponses were collected via Google Forms.

#todo("disclaimer: questionnaires team effort")

After collection, portions of the data were further processed to enable analysis using Python.
Participants' responses to the tasks were manually tagged to obtain total counts of identified issues for the solvability task and total counts of answered questions for the pacing analysis tasks, as well as number of correct responses for both according to the answer key.

Additionally, some of the demographic data (education, occupation, previous experience with whiteboard tools) was collected in a free-form format and was manually codified.

#todo("mention parsing of protocol into csv?")
#todo("mention different sets of data?")

#todo("disclaimer human error")

=== Data Analysis

done in python.
data from multiple sources joined into complete dataset via participant IDs.

statistical tests used: Wilcoxon signed-rank test, Mann-Whitney U, Kruskal-Wallis and Dunn's, Levene.
reasoning: non-parametric tests (no assumptions made about underlying distributions)
for Wilcoxon and mann-whitney U: two-sided unless specified otherwise.
#todo("make sure this is true lol")

== User Study Results

=== Participants

In total, 24 people participated in the study.
Ages ranged from 19 to 32 years, with an average of 23.625 years.
15 indicated their gender as male, 5 as female and 4 preferred not to say.
#todo("educational/occupational background")
15 participants, or 62.5%, indicated previous experience with whiteboard tools.
No participants indicated previous experience with tools specific to game design.
#todo("projects")

// #todo("group breakdown?")

=== Results Solvability

#todo("give overview over subsection") task completion, differences between groups, differences between task versions

/*
==== Data Processing

- spoken answers recorded in protocol -> manual count of total identified issues, manual check against answer key and count of true positives
- inspection of miro boards -> modifications to boards and if so, which ones

#todo("add disclaimer human error")
*/

==== Task Completion

The two main metrics used to measure task completion are
- the total number of identified issues in either tool and
- the F1 score in either tool

This part of the analysis will first compare the two task completion metrics between the tools across all participants, and then assess the impact of indicated whiteboard tool experience and use of Miro functionalities respectively.

===== Overall Task Completion
Overall, participants claimed significantly less (Wilcoxon signed-rank test: $T = 48.5$, $p = 0.00564929988211376$) solvability issues in pix:e, see @fig:s-total.
The overall answer quality as measured by the F1 score (see @fig:s-f1) is also significantly lower in pix:e (Wilcoxon signed-rank test, $T = 34.0$, $p = 0.0009066055498154164$).

#grid(
    columns: 2,
    inset: (x: 5pt, y: 5pt),
    grid.cell([#figure(
        image("assets/05/solvability-total-boxplot.png"),
        caption: "Distribution of total number of identified issues by tool"
    ) <fig:s-total> ]),
    grid.cell([#figure(
        image("assets/05/solvability-f1-boxplot.png"),
        caption: "Distribution of F1 scores by tool"
    ) <fig:s-f1> ])
)

#h(1.8em)
===== Impact of Whiteboard Tool Experience
In pix:e, participants who indicated previous experience with whiteboard tools tended to claim more issues than participants, see @fig:s-total-by-wb-exp.
median 1 for participants without whiteboard experience, 2 for participants with whiteboard experience, Mann-Whitney $U = 96.5$, $p < 0.05$.
#todo("effect size").
#todo("difference between performance in Miro").
However, the performance difference between the two tools still remains, as participants with whiteboard tool experience still identified significantly fewer issues in pix:e than in Miro (Wilcoxon signed-rank test: $T = 97.5$, $p < 0.05$).
A similar effect can be observed for the F1 scores, as the median F1 score in pix:e is significantly higher (Mann-Whitney $U = 99.5$, $p < 0.05$) in participants who indicated previous whiteboard experience, see @fig:s-f1-by-wb-exp.
//F1 medians 0.25 and 0.285, Mann-Whitney
#todo("effect size?")

#grid(
    columns: 2,
    inset: (x: 5pt, y: 5pt),
    grid.cell([#figure(
        image("assets/05/solvability-total-by-wb-exp.png"),
        caption: "Distribution of total number of identified issues by tool and indicated whiteboard tool experience"
    ) <fig:s-total-by-wb-exp>]),
    grid.cell([#figure(
        image("assets/05/solvability-f1-by-wb-exp.png"),
        caption: "Distribution of F1 scores by tool and indicated whiteboard tool experience"
    ) <fig:s-f1-by-wb-exp> ])
)

#h(1.8em)
===== Impact of Miro Tool Usage
Only 6 participants used any editing functionality in Miro.
3 participants marked issues, 1 participant highlighted valid paths, and 2 participants tracked the available inventory for pathfinding.
Of the 6 participants, 5 had indicated previous experience with whiteboard tools.
As suggested by @fig:s-total-by-miro-usage and @fig:s-f1-by-miro-usage, there is no obvious impact of Miro tool use on the task completion metrics within Miro.
#todo("phrasing") total issues identified: median 2 without Miro usage, 2.5 with Miro usage, Mann-Whitney $U = 57.5$, $p=0.4169872469244896$ #todo("effect size?").
F1: median 0.5 with Miro usage, 0.39285714285714285 without Miro usage, Mann-Whitney $U = 57.5$, $p=0.4169872469244896$ #todo("effect size?")

#grid(
    columns: 2,
    inset: (x: 5pt, y: 5pt),
    grid.cell([#figure(
        image("assets/05/solvability-total-by-miro-usage.png"),
        caption: "Distribution of total number of identified issues by tool and use of Miro functionalities"
    ) <fig:s-total-by-miro-usage> ]),
    grid.cell([#figure(
        image("assets/05/solvability-f1-by-miro-usage.png"),
        caption: "Distribution of F1 scores by tool and use of Miro functionalities"
    ) <fig:s-f1-by-miro-usage> ])
)

#h(1.8em)
===== Summary
Participants generally showed significantly lower task completion and answer quality in pix:e compared to Miro.
Within pix:e, participants who reported previous experience with whiteboard tools achieved better results than participants who did not.
A possible explanation for this observation is that pix:e may cater more to power users.
Within Miro, participants who made use of built-in Miro functionalities did not achieve significantly better results than other participants.
Basic Miro functionalities (without involved custom setup/templating) seem to be less suited to support users with this specific analytical task type.
- #todo("reference feedback")

==== Recorded Times

- #todo("times to first identified issues")

==== Differences Between Groups

To assess differences between the 4 user study groups, the two task completion metrics for both tools will be compared across all four groups, and additionally via the two variation dimensions (tool order and task version order).

===== All Groups
While there is some variation in task completion metrics across the four groups (see @fig:s-total-by-group and @fig:s-f1-by-group), there is no evidence for the distribution of any group dominating in either tool for total claimed issues according to the Kruskal-Wallis test (Miro: $H = 1.038, p=0.792$, pix:e: $H = 6.302, p = 0.098$) or F1 score (Miro: $H = 6.782$, $p = 0.079$, pix:e: $H = 6.121$, $p = 0.106$)

#grid(
    columns: 2,
    inset: (x: 5pt, y: 5pt),
    grid.cell([#figure(
        image("assets/05/solvability-total-by-group.png"),
        caption: "Distribution of total issues claimed by group"
    ) <fig:s-total-by-group> ]),
    grid.cell([#figure(
        image("assets/05/solvability-f1-by-group.png"),
        caption: "Distribution of F1 scores by group"
    ) <fig:s-f1-by-group> ])
)

#h(1.8em)
===== First Tool
The no evidence for total number of identified issues (see @fig:s-total-by-first-tool) in either tool differing based on which tool was used first (in pix:e: $U = 56.0$, $p approx 0.176$, in Miro: $U=  61.0$, $p approx 0.525$).
Also, participants still claimed significantly more issues in Miro than pix:e, regardless of which tool was used first (Miro first: $U = 113.5$, $p approx 0.007$, pix:e first: $U=109.5$, $p approx 0.014$).
However, for the F1 scores (see @fig:s-f1-by-first-tool), the tool order does seem to make a difference: The pix:e-first group achieved higher median F1 score in both tools, with the difference being significant according to the Mann-Whitney U test (in Miro: $U = 34.5$, $p approx 0.013$, in pix:e: $U = 36.0$, $p approx 0.018$).
#todo("speculate why?") The difference in F1 scores between the two tools for the pix:e-first group remains significant ($U = 120.5$, $p approx 0.002$).

#grid(
    columns: 2,
    align: bottom,
    inset: (x: 5pt, y: 5pt),
    grid.cell([#figure(
        image("assets/05/solvability-total-by-first-tool.png"),
        caption: "Distribution of total claimed issues by first tool"
    ) <fig:s-total-by-first-tool> ]),
    grid.cell([#figure(
        image("assets/05/solvability-f1-by-first-tool.png"),
        caption: "Distribution of F1 scores by first tool"
    ) <fig:s-f1-by-first-tool> ])
)

#h(1.8em)
===== First Task
The order of task variants (see @fig:s-total-by-first-task and @fig:s-f1-by-first-task) did not seem to affect the total number of identified issues (in Miro: $U = 66.5$, $p approx 0.762$, in pix:e: $U = 61.0$, $p approx 0.264$) nor the F1 score (in Miro: $U = 51.0$, $p approx 0.108$, in pix:e: $U = 76.5$, $p approx 0.812$).

#grid(
    columns: 2,
    inset: (x: 5pt, y: 5pt),
    grid.cell([#figure(
        image("assets/05/solvability-total-by-first-task.png"),
        caption: "Distribution of total claimed issues by first task version"
    ) <fig:s-total-by-first-task> ]),
    grid.cell([#figure(
        image("assets/05/solvability-f1-by-first-task.png"),
        caption: "Distribution of F1 scores by first task version"
    ) <fig:s-f1-by-first-task> ])
)

==== Differences Between Task Versions

To verify whether the two task variants were indeed sufficiently comparable, the task completion metrics across _both_ tools for each variant are compared.
The distribution of total issues claimed skews a bit lower for task variant B (see @fig:s-total-a-vs-b) but not significantly so (one-sided Wilcoxon signed-rank test: $T = 186.0$, $p approx 0.069$).
The distributions of F1 scores (see @fig:s-f1-a-vs-b) are comparable between the two task variants (two-sided Wilcoxon signed-rank test:  $T = 114.5$, $p approx 0.310$)

#grid(
    columns: 2,
    inset: (x: 5pt, y: 5pt),
    grid.cell([#figure(
        image("assets/05/solvability-total-a-vs-b.png"),
        caption: "Distribution of total issues claimed by task version"
    ) <fig:s-total-a-vs-b> ]),
    grid.cell([#figure(
        image("assets/05/solvability-f1-a-vs-b.png"),
        caption: "Distribution of F1 scores by task version"
    ) <fig:s-f1-a-vs-b> ])
)

=== Results Pacing

#todo("give overview over subsection") task completion, differences between groups, differences between task versions
#todo("add disclaimer human error")
#todo("effect sizes")

==== Task Completion <res-p-task-completion>

The metrics used to measure task completion for the pacing analysis tasks are
- the total number of answered questions and
- the number of correctly answered questions
- the number of wrongly answered questions

This subsection follows the analogous section for the Solvability task in structure: first a comparison of the task completion metrics between the tools, then an analysis of the impacts of the indicated whiteboard tool experience and use of Miro functionalities.

===== Overall Task Completion
Regarding the total number of answered questions (see @fig:p-total), there is no indication of a significant difference in distributions between the two tools according to Wilcoxon signed-rank test ($T = 96.5$, $p approx 0.747$).
//median of number of answered questions higher for pix:e, even though distribution skews higher for miro.
//within participants: median same, but 25th percentile skews a bit lower.
The same holds for both the correctly answered questions ($T=98.5$, $p approx 0.806$) and the wrongly answered questions ($T=53.5$, $p approx 0.702$), as visualized in @fig:p-right and @fig:p-wrong.
There is a slight trend towards a higher median in total and correct answers in pix:e, but overall the distribution skews higher for miro.
#todo("interpret?") #todo("adjust image zoom?")

#grid(
    columns: 3,
    inset: (x: 5pt, y: 5pt),
    grid.cell([#figure(
        image("assets/05/pacing-total.png"),
        caption: "Distribution of total number of answered questions by tool"
    ) <fig:p-total> ]),
    grid.cell([#figure(
        image("assets/05/pacing-right.png"),
        caption: "Distribution of number of correctly answered questions by tool"
    ) <fig:p-right> ]),
    grid.cell([#figure(
        image("assets/05/pacing-wrong.png"),
        caption: "Distribution of number of wrongly answered questions by tool"
    ) <fig:p-wrong> ])
)

#h(1.8em)
===== Impact of Whiteboard Tool Experience
Within pix:e, participants with whiteboard experience tended to answer significantly more questions (see @fig:p-total-by-wb-exp): the median 4 with whiteboard experience, 3 without whiteboard experience, Mann-Whitney $U = 103.5$, $p approx 0.015$.
They also gave significantly more correct answers (see @fig:p-right-by-wb-exp): median 3 with whiteboard experience, 2 without, Mann-Whitney $U = 103.0$, $p approx 0.017$.
- slight skews in median/distribution: number of answered questions higher in pix:e than miro for participants with whiteboard experience, total number and number of correct answers lower in pix:e than Miro for people without whiteboard experience.
however, differences in distribution do not seem to be statistically significant (Wilcoxon signed-rank test: $T = 38.0$, $p approx 0.326$ for total answers in pix:e vs Miro from participants with Whiteboard experience, $T = 15.0$, $p approx 0.207$ for total answers from participants without whiteboard experience)

#grid(
    columns: 3,
    inset: (x: 5pt, y: 5pt),
    grid.cell([#figure(
        image("assets/05/pacing-total-by-wb-exp.png"),
        caption: "Distribution of total number of answered questions by tool and indicated whiteboard tool experience"
    ) <fig:p-total-by-wb-exp> ]),
    grid.cell([#figure(
        image("assets/05/pacing-right-by-wb-exp.png"),
        caption: "Distribution of number of correctly answered questions by tool and indicated whiteboard tool experience"
    ) <fig:p-right-by-wb-exp> ]),
    /*
    grid.cell([#figure(
        image("assets/05/pacing-wrong-by-wb-exp.png"),
        caption: "Distribution of number of wrongly answered questions by tool and indicated whiteboard tool experience"
    ) <fig:p-wrong> ])
    */
)

#h(1.8em)
===== Impact of Miro Tool Usage
- control for usage of Miro functionalities (6 participants): 1x sticky note color change to highlight a node/room, 4x calculations in textbox/sticky note/via pen, 1x recording path in textbox
- median of total answered questions and correctly answered questions in Miro lower for participants using functionality in Miro (see @fig:p-total-by-miro-usage and @fig:p-right-by-miro-usage), but not significantly so (Mann-Whitney test: $U = 32.5$, $p=0.07540184146884174$ for total answers, $U = 33.5$, $p=0.08497339144083382$ for correct answers).
- also, median for total number of answered questions and number of correctly answered questions larger in pix:e than miro for participants using Miro functionality, but not statistically significant (Wilcoxon signed-rank test: $T = 11.0$, $p=0.1875$ for total answers, $T=13.5$, $p=0.296875$ for correct answers)

#grid(
    columns: 3,
    inset: (x: 5pt, y: 5pt),
    grid.cell([#figure(
        image("assets/05/pacing-total-by-miro-usage.png"),
        caption: "Distribution of total number of answered questions by tool and use of Miro functionalities"
    ) <fig:p-total-by-miro-usage> ]),
    grid.cell([#figure(
        image("assets/05/pacing-right-by-miro-usage.png"),
        caption: "Distribution of number of correctly answered questions by tool and use of Miro functionalities"
    ) <fig:p-right-by-miro-usage> ]),
    /*
    grid.cell([#figure(
        image("assets/05/pacing-wrong-by-miro-usage.png"),
        caption: "Distribution of number of wrongly answered questions by tool and use of Miro functionalities"
    ) <fig:p-wrong> ])
    */
)

#h(1.8em)
===== Summary
Overall, the data showed no significant difference in task completion and answer quality between tools for the pacing analysis task.
within pix:e, participants with whiteboard experience achieved better results than participants without.
within Miro, participants using Miro functionalities did not achieve better results than participants not using Miro functionalities.

- possible explanation/interpretation: similar to first task.
pix:e caters better to power users.
Miro functionalities (without involved custom setup/templating) seem to be less suited to support users with this specific analytical task type.

==== Recorded Times

- #todo("time per question")

==== Differences Between Groups

Analogously to the Solvability task results, the task completion metrics are analyzed across the 4 user study groups and compared for the two underlying groupings.

===== All Groups
In pix:e, there is no evidence for a significant difference in distributions across groups for either total questions answered (Kruskal-Wallis $H approx 2.111$, $p approx 0.550$) or correctly answered questions (Kruskal-Wallis $H approx 3.084$, $p approx 0.379$).
In Miro, however, there is a significant difference in distributions for both the total questions answered ($H = 12.251$, $p approx 0.007$) and correctly answered questions ($h = 10.571$, $p approx 0.014$).
Dunn's post-hoc test reveals that specifically the difference between the "BM" and "BP" groups is significant in both Miro ($p approx 0.004$) and pix:e ($p approx 0.008$).
A possible explanation for this contrast is that as task B is apparently more challenging (see @res-p-a-vs-b), when encountering it as a first task (as participants of the B-groups did), the previously (@res-p-task-completion) mentioned slight difference between the tools may be amplified.

#grid(
    columns: 2,
    inset: (x: 5pt, y: 5pt),
    grid.cell([#figure(
        image("assets/05/pacing-total-by-group.png"),
        caption: "Distribution of total questions answered by group"
    ) <fig:p-total-by-group> ]),
    grid.cell([#figure(
        image("assets/05/pacing-right-by-group.png"),
        caption: "Distribution of correctly answered questions by group"
    ) <fig:p-right-by-group> ])
)


#h(1.8em)
===== First Tool
In Miro, there is a significant difference in task completion metrics between Miro-first and pix:e-first groups in both total answers (Mann-Whitney $U = 23.0$, $p approx 0.002$) and correct answers (Mann-Whitney $U = 39.0$, $p approx 0.027$).
In pix:e, there is no such difference (Mann-Whitney $U = 67.5$, $p approx 0.813$ for total answers, $U = 70.5$, $p approx 0.953$ for correct answers).
#todo("interpret")

#grid(
    columns: 2,
    inset: (x: 5pt, y: 5pt),
    grid.cell([#figure(
        image("assets/05/pacing-total-by-first-tool.png"),
        caption: "Distribution of total answered questions by first tool"
    ) <fig:p-total-by-first-tool> ]),
    grid.cell([#figure(
        image("assets/05/pacing-right-by-first-tool.png"),
        caption: "Distribution of correctly answered questions by first tool"
    ) <fig:p-right-by-first-tool> ])
)

#h(1.8em)
===== First Task
The overall distributions of task completion metrics in Miro do not differ significantly (Mann-Whitney $U = 72.0$, $p approx 1.0$ for total answers, $U = 75.5$, $p approx 0.859$ for right answers).
There is a significant difference in variance in both metrics for performance in Miro in participants who encountered task variant B first (Levene's test $W approx 4.313$, $p approx 0.0497$), which is expected from the aforementioned large difference in results between the B-first groups (see @res-p-a-vs-b).

#grid(
    columns: 2,
    inset: (x: 5pt, y: 5pt),
    grid.cell([#figure(
        image("assets/05/pacing-total-by-first-task.png"),
        caption: "Distribution of total answered questions by first task version"
    ) <fig:p-total-by-first-task> ]),
    grid.cell([#figure(
        image("assets/05/pacing-right-by-first-task.png"),
        caption: "Distribution of correctly answered questions by first task version"
    ) <fig:p-right-by-first-task> ])
)

==== Differences Between Task Versions <res-p-a-vs-b>

Analogously to the pacing analysis task, this analysis inspects the results for any differences in task completion metrics between the two task versions.
As seen in @fig:p-total-a-vs-b and @fig:p-right-a-vs-b, both the distribution of total answered questions and the distribution of correctly answered questions skew lower for task variant B (dungeon LA_2).
For both distributions, the difference is statistically significant according to sigle-sided Wilcoxon signed-rank tests (total answered questions: $T = 176.0$, $p approx 0.004$, correctly answered questions: $T = 195.0$ $p approx 0.000$).
The median of wrongly answered questions is higher for task variant B, though the difference is not significant (one-sided Wilcoxon signed-rank: $T = 36.5$, $p approx 0.083$).

#grid(
    columns: 3,
    inset: (x: 5pt, y: 5pt),
    grid.cell([#figure(
        image("assets/05/pacing-total-a-vs-b.png"),
        caption: "Distribution of total questions answered by task version"
    ) <fig:p-total-a-vs-b> ]),
    grid.cell([#figure(
        image("assets/05/pacing-right-a-vs-b.png"),
        caption: "Distribution of questions answered correctly by task version"
    ) <fig:p-right-a-vs-b> ]),
    grid.cell([#figure(
        image("assets/05/pacing-wrong-a-vs-b.png"),
        caption: "Distribution of questions answered wrongly by task version"
    ) <fig:p-wrong-a-vs-b> ])
)

These observations point to the conclusion that for the pacing analysis task, variant B may have been more challenging than variant A.

=== Results UEQ-S

The UEQ-S consists of 8 items divided into 2 categories:
- pragmatic quality ("relate to the tasks or goals the user aims to reach") and
- hedonic quality ("related to pleasure or fun while using the product")

Each item is a pair of opposing adjectives, and participants were asked to place StatePx on a 7-point scale between the adjectives.
This translates to a numeric scale ranging from -3 to 3.

The responses to the UEQ-S questionnaire were evaluated using the analysis tool provided by the authors #cite(<hinderksBenchmarkShortVersion2018>).
It provides mean scores for each item and rates the pragmatic, hedonic, and overall score against a benchmark.
#todo("what is the benchmark?")

#figure(
  image("assets/05/ueq-mean-value-per-item.png"),
  caption: "Mean values per item in the UEQ-S"
) <fig:ueqs-means>

@fig:ueqs-means shows the mean scores for each item.
The fourth and weakest item is the pair "confusing vs clear".
This relatively low (albeit positive) score is in line with participant feedback, which included a number of UI issues (@feedback-written).

pragmatic quality: mean 0.823 (-> below average, i.e. better than 25% of benchmark), hedonic quality: mean 1.385 (-> good, i.e. better than 75% of benchmark), overall: mean 1.104 (-> above average, i.e. better than 50% of benchmark)

#figure(
  image("assets/05/ueq-against-benchmark.png"),
  caption: "Comparison of UEQ-S scores against benchmark"
)

#todo("control for whiteboard experience?")

=== Results Comparative Questions <res-comparative-questions>

- C-Q1: "Compared to Miro, the system made it easier to analyze dungeon designs."
- C-Q2: "Compared to Miro, I felt more confident in my answers."
- C-Q3: "Compared to Miro, I was able to complete the tasks more efficiently."
- C-Q4: "If I were analyzing game levels in practice, I would prefer using the system over a general-purpose whiteboard."

Answers were given on a 5-point Likert scale, ranging from fully disagree (1) to fully agree (5).
@fig:cq-histogram shows the answer distributions for each question.

#figure(
  image("assets/05/comparative-questions-histogram.png"),
  caption: "Answer distributions for system preference questions, across all participants"
) <fig:cq-histogram>

Overall, participants indicated a preference for StatePx over Miro, though answers were mixed for the first question(s) in particular.
This result is in line with the high hedonic quality indicated by the UEQ-S.

A higher score variance/split is observed in participants with whiteboard tool experience in the first three questions, see @app-cq-by-wb-exp.
For last question however, participants who indicated previous experience with whiteboard tools indicated a particularly strong preference for pix:e #todo("back this up").
Answers for the first three questions may be divided because on one hand, these participants may be more used to a Miro-like UI and thus more comfortable using Miro, but on the other hand, they may also be better equipped to recognize the advantage of a dedicated tool compared to a generic whiteboard tool.

=== Written Feedback from Participants <feedback-written>

- context: once after first part of user study (not described here #todo("add to appendix + reference?")), once at very end of study
- see complete (relevant) freeform answers in Appendix @app-written-feedback

==== Usability/UI

- issues/confusion when adding locks (5x) due to menu placement
- addition of keys not included in right-click menu of nodes (2x)
- low contrast between background and nodes (6x)

==== Functionality

- locks not visually distinguishable (6x)
- confusion about diagram tick labels
- sum/average in diagrams, more interactivity in general
- unclear highlighting in pathfinding (2x)

=== Observed Behavior and Verbal Feedback from Participants <observed-verbal>

- all protocol data, thus may contain human error
- contains: verbal comments/questions while completing the tasks, specific approaches to tool use, verbal feedback

- 5 participants required clarification that all locks were visualized by the same symbol (4 of them completed the task in Miro first, thus may have been primed to expect similar visualization)
- 10 participants did some form of successive pathfinding in pix:e.
selecting of various goal nodes for the given start node and subsequent identification of locked edges as those between a node reachable from the start and a node not reachable from the start
- 3 participants (all Miro-first groups) asked whether enemies respawn for the pacing task. while unclear in task description, still notable that only Miro-first participants asked this. setup in pix:e may have primed participants to understand the respawn implicitly and apply the same principle in Miro. -> potential improvement for diagrams setup, users should be prevented from making/falling victim to implicit assumptions!

=== Validity of A/B Test

- compare results across groups -> statistical test? (ANOVA for 3+ groups)
- compare demographics across groups

== Limitations

- data collection: human errors
- not all functionality included (e.g. soft gates, creation of component/lock/key definitions, broder functionalities of pix:e)

== Post-Study Improvements

An initial rount of improvements was implemented after the study based on the collected feedback and observations. #todo("reference?")

=== Improved Visual Representation of Locks & Keys

In the initial evaluated version, all lock assignments on edges were represented by the same symbol.
A notable number of participants explicitly mentioned that distinct visualization of different lock types would improve the experience or expressed confusion during the tasks due to the initial representation.

Emojis were chosen as the improved visual representation due to their wide range of options and expected familiarity of users with the available symbols.
The original data model was extended by a `symbol` for both locks and keys.
Symbols can be selected via an emoji picker when creating or editing definitions.
The default values are 🔒 for lock definitions and 🔑 for key definitions.

In the chart view (see @improved-symbols-chart), key assignments are now represented using the symbol, with a tooltip showing the name of definition on hover.
Edges show the symbols of all assigned locks as their label, including their multiplicity.
As edge tooltip are not native in the current framework, a legend popover was implemented instead to assist users in understanding the visual representation.

#figure(
    image("assets/05/improved-symbols-in-chart.png"),
    caption: "Improved visual representation of locks and keys in chart"
) <improved-symbols-chart>

The legend is located in the bottom right corner of the chart and can be shown or hidden via a button.
It shows an overview of available lock and key definitions in separate tabs (see @improved-legend-locks and @improved-legend-keys), including notable features for each definition (e.g. symbol, name, consumability for keys, unlocking key definitions for locks).

#grid(
    columns: 2,
    align: bottom,
    grid.cell([
        #figure(
            image("assets/05/improved-symbols-legend-locks.png", width: 75%),
            caption: "Legend of lock types, including unlocking keys"
        ) <improved-legend-locks>
    ]),
    grid.cell([
        #figure(
            image("assets/05/improved-symbols-legend-keys.png", width: 75%),
            caption: "Legend of key types, including consumability and key type"
        ) <improved-legend-keys>
    ]),
)

To align the visual representation of lock and key types throughout the player experience module, the symbols were also included wherever definitions were referenced, in particular in the assignment creation modals.

#grid(
    columns: 2,
    align: bottom,
    grid.cell([
        #figure(
            image("assets/05/improved-symbols-edit-locks.png", width: 75%),
            caption: "Lock assignment creation modal with symbols"
        ) <improved-modal-locks>
    ]),
    grid.cell([
        #figure(
            image("assets/05/improved-symbols-key-creation.png", width: 75%),
            caption: "Key assignment creation modal with symbols"
        ) <improved-modal-keys>
    ]),
)

=== Reachability Analysis

Many participants #todo("number + reference") either explicitly reported missing a reachability analysis functionality in open feedback or were observed to conduct a reachability analysis during the solvability task on their own (10 participants, see @observed-verbal).

Implementation of this improvement is straightforward as the underlying Dijkstra algorithm already performs an implicit reachability analysis.
In particular, it tracks distances of nodes from the start nodes, with the initial value being `Infinity`.
#todo("explain this better") Consequently, all nodes with distance < `Infinity` after the algorithm has concluded are reachable and can simply be filtered for.

In case of failed pathfinding, unreachable nodes are then highlighted (see @improved-reachability).
#todo("confirm/wait for julians pr feedback")

#figure(
    image("assets/05/improved-reachability-analysis.png", width: 50%),
    caption: "Improved visual feedback about reachability on failed pathfinding (LA_3 as example)"
) <improved-reachability>

=== Increased Contrast of Nodes Against Background

6 participants reported the low contrast between nodes and background as a usability issue, especially when zoomed out (see @feedback-written).
This issue was remedied by adding a new color in the css theme specifically for backgrounds and using it in the chart canvas (see @improved-contrast).

#figure(
    grid(
        columns: 2,
        inset: 5pt,
        image("assets/05/improved-contrast-light.png", width: 90%),
        image("assets/05/improved-contrast-dark.png", width: 90%)
    ),
    caption: "Increased contrast due to adjusted background color in both light and dark modes"
) <improved-contrast>

#load-bib()