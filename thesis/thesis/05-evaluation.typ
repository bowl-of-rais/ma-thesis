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

The implemented functionalities were evaluated with a user study.
This section describes the methodology of the study, including the overall setup and design, and presents its results.

== Methodology

This sub-section first describes the goal and high-level design of the user study.
It then details the chosen use case and task designs and outlines the collected data.

=== Goal

The user study's main questions were whether the implemented analysis functionalities are both helpful and interesting.
To assess the helpfulness aspect, participants were given tasks designed to evaluate the impact of the tool on their performance.
Their interest was then captured via questionnaires and additional participant feedback.

=== High-Level User Study Design

The evaluation of the functionalities implemented as part of this work was the second part of a larger study conducted in a joint team effort.
The first part of the study was concerned with assessing the usability of the system.
In particular, participants were asked to model a Zelda dungeon in the tool, including locks and keys.
Consequently, participants were already familiarized with the use case context and basic functions of the tool when approaching the tasks described here.
Task-specific functionalities (e.g., pathfinding and highlighting, as well as configuration of diagrams) were introduced to the participants prior to the respective tasks (see @app-us-tasks).

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
  [AM],
  [AP],
  [*Variant B first*],
  [BM],
  [BP],
  ),
  caption: "Definition of the 4 user study participant groups"
) <user-study-groups>

The chosen baseline tool was Miro, a general-purpose whiteboard tool that is used as a game design tool.
As a notable example, it was used in the development of "Subnautica: Below Zero" to create the in-game world's layout and how players may progress through it. #cite(<flayraUsingMiroGame2021>).

To restrict the overall time per participant, especially in context of the joint study design, the tasks were designed in such a way that participants were given a set amount of time (5 minutes) for each task variant.

The target demographic was people with some understanding of game design.
Participants were thus mainly recruited in a university lecture from a games engineering study course, though participants also included computer science students with some familiarity with video games.

The study was conducted exclusively in person.
For details on data collection, see @eval-data-collection.

User study participants only interacted with the player experience module.
It was thus presented as a stand-alone tool called "StatePx".

=== Task Designs

The functionalities were evaluated via two distinct tasks: a "Solvability" task, which targeted the functionalities around locks and keys, and a subsequent "Pacing Analysis" task, which focused on the diagram function.
Splitting the evaluation into two tasks reduced the context required to understand and complete each task and was an intentional choice to limit the amount of new information participants were confronted with at a time.
The "Pacing Analysis" task assumed an understanding of pathfinding including locks and keys and was placed after the "Solvability" task.

For the complete task description including all dungeons and the respective answer keys, see @app-us-design.

==== Zelda Dungeons from the VGLC dataset

The use cases chosen for this study were dungeons from the Legend of Zelda video game series.
As the use case is concerned with modeling individual dungeons or levels, it corresponds to a low-level modeling approach.
This is more fitting for this particular study as the individual charts are self-contained and sufficiently complex while also being taken from the same context.  

The exact level designs were extracted from the Video Game Level Corpus #cite(<summervilleVGLCVideoGame2016>).
While the dataset provides data from three different Legend of Zelda game, the dungeons for both tasks and all variants were chosen from the same game, "The Legend of Zelda: Link's Awakening" #cite(<linksAwakening1993>), to ensure consistency in details such as item, lock, or key types and the overall complexity and structure of the dungeons.
// The dungeons from the game "The Legend of Zelda: Link's Awakening" were found to be best suited for the evaluation tasks. #todo("reason")

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
      image("assets/05/multi-screen-room-example-la2.png", width: 90%),
      caption: [Example of a multi-screen room in level LA_2 #cite(<summervilleVGLCVideoGame2016>)]
    ) <multiscreen-example>
  ]),
  grid.cell([
    #figure(
      image("assets/05/multi-screen-numbering-example-miro.png", width: 90%),
      caption: "Modeling of a multi-screen room in Miro"
    ) <multiscreen-node-numbers>
  ])
)

#h(1.8em)
===== Modeling Dungeons in pix:e vs Miro
In pix:e, each room was modeled by a node.
Any keys, and key-like items (e.g. bombs) were modeled as `PxKeys`, and other room data were modeled as `PxComponents`.
The resulting visualization is as described previously in @impl-diagrams and @impl-lk.

Miro as a general-purpose whiteboard tool offers sticky notes that can be connected by arrows/lines.
They were thus used to represent the individual nodes.
Node-specific information was simply written into the sticky notes as text, and locks were added as edge labels.
The different lock and key types were encoded as emojis, and an additional sticky note served as a legend (see @miro-legend).
This encoding was used to obtain a visualization that is as clear and straightforward as possible given the available options in Miro.
Both visualizations can be seen in @app-dungeons.

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
As for pix:e, participants were permitted to use the aforementioned pathfinding/highlighting functions and fix issues (e.g., add a missing key) after reporting them.
This would have allowed them to perform pathfinding under different conditions and find issues in previously unreachable parts of the chart.

The dungeons chosen for the two variants of this tasks were the third (LA_3) and fourth (LA_4) dungeons from "Link's Awakening" (LA_3 and LA_4 in #cite(<summervilleVGLCVideoGame2016>, form: "prose")).
Dungeon LA_3 is used in variant A of the task, and dungeon LA_4 is used in variant B.
The main criterion for this choice was the dungeons' size, as they are sufficiently large and thus make the task sufficiently complex while still being feasible manually in Miro.
Their node count is around the 75th percentile across all VGLC Zelda data.
The two dungeons, being subsequent levels from the same game, have comparable size and complexity (based on the outgoing ranks of nodes) and similar numbers of keys/locks (see @solvability-dungeon-numbers). LA_4 was additionally extended by four nodes, three edges, and four keys to accommodate the size difference between the two dungeons.

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

For this task, the charts included information regarding the locations of locks and keys and indicated start and boss nodes.

To make the dungeons unsolvable, 6 issues of varying difficulty were added in each dungeon.
For both, this included
- 1 area (group of nodes) that is unreachable due to wrong edge directionality
- 1 hardlock, where players definitely are unable to progress (i.e., a reachable node with no outgoing edge)
- 2 softlocks, where players may or may not be unable to progress
- 2 instances of missing key(s), i.e., an edge not being unlockable with the keys a player could have collected on any path from the start node

See @la3-vglc for an impression of the original dungeon layout and @la3-miro for the adapted version with issues in Miro for LA_3.
Full-size images and pix:e versions are included in @app-s-dungeons.

#grid(
  columns: 2,
  inset: 5pt,
  grid.cell([
    #figure(
      image("assets/05/la3-vglc.png"),
      caption: [Annotated screen captures of LA_3 from the VGLC #cite(<summervilleVGLCVideoGame2016>)]
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

For this task, the choice fell on smaller dungeons, in particular the first and second dungeons of "Link's Awakening" (LA_1 and LA_2 in #cite(<summervilleVGLCVideoGame2016>, form: "prose")).
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

An additional criterion for this task was a clear division of the critical path into three sections that can be used for comparative analysis of component values along (sub-)paths:
  - A: from the start room to the room where players obtain a new ability
  - B: from the room with a new ability to the room with the boss key
  - C: from the room with the boss key to the boss fight room
A consequence of this aspect is the critical paths containing little backtracking, which is also beneficial as nodes (and thus likely component values) are more distinct between sections.

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
      caption: [Annotated screen captures of LA_1 from the VGLC #cite(<summervilleVGLCVideoGame2016>)]
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

After completing all tasks, participants were given the UEQ-S #cite(<schreppDesignEvaluationShort2017>) to assess pix:e and a short questionnaire comparing Miro and StatePx (see @res-comparative-questions).
Like the demographic data, the responses were collected via Google Forms.

After collection, portions of the data were further processed to enable analysis using Python.
Participants' responses to the tasks were manually tagged to obtain total counts of identified issues for the solvability task and total counts of answered questions for the pacing analysis tasks, as well as number of correct responses for both according to the answer key.
Additionally, some of the demographic data (education, occupation, previous experience with whiteboard tools) was collected in a free-form format and was manually codified.
Despite best efforts, the results may thus contain minor errors due to manual processing.

The choices of which demographic data to collect and which questionnaires to use were done in the team to align all parts of the user study.

=== Data Analysis

After collection and processing, all data was analyzed in Python using the pandas, sciPy and scikit-learn libraries.
//data from multiple sources joined into complete dataset via participant IDs.

Apart from visual inspection of histograms and box plots, data was analyzed using the following statistical significance tests:

- Wilcoxon signed-rank test: difference in distributions of matched samples (i.e., two datasets from the same group of participants)
- Mann-Whitney U test: difference in distributions of unmatched samples (i.e., two datasets from different groups of participants)
- Kruskal-Wallis test: difference in distributions of more than two independent groups
- Dunn's test: pairwise difference in distributions of more than two independent groups, typically used after Kruskal-Wallis to identify the deviating distributions
- Levene's test: difference in variance between two or more groups

All statistical tests used are non-parametric, i.e. do not assume normal distribution of the data.
The Wilcoxon and Mann-Whitney U tests were conducted assuming a two-sided alternative hypothesis (i.e., the distributions differ in either direction) unless specified otherwise.
For all tests, $p < 0.05$ is considered significant.

== User Study Results

=== Participants

In total, 24 people participated in the study, i.e., 6 per group.
Ages ranged from 19 to 32 years, with an average of about 24 years.
15 indicated their gender as male, 5 as female and 4 preferred not to say.
Most participants reported an educational background in Games Engineering (13) or Informatics (5), with one participants having a Master's in Bioinformatics.
The rest of the participants only reported that they were students without specifying their exact study course.
Most participants (19) were Bachelor's or Master's students at the time.
15 participants, or 62.5%, indicated previous experience with whiteboard tools.
All participants indicated little (3) or no (21) previous experience with tools specific to game design.
For most participants, the number of projects they had worked on is between 1 to 10 (average: 6) projects, with one outlier of 25 projects. 
In some cases, this number does not contain any game-related projects.
// #todo("group breakdown?")

=== Results Solvability

This sub-section presents the results for the solvability task in terms of task completion, compared between the two tools and additional stratifications (such as previous experience of participants with whiteboard tools or the different user study groups).

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
Overall, participants claimed significantly less (Wilcoxon signed-rank test: $T = 48.5$, $p approx 0.006$) solvability issues in pix:e, see @fig:s-total.
The overall answer quality as measured by the F1 score (see @fig:s-f1) is also significantly lower in pix:e (Wilcoxon signed-rank test, $T = 34.0$, $p approx 0.001$).

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
In pix:e, participants who indicated previous experience with whiteboard tools claimed significantly more issues (Mann-Whitney $U = 96.5$, $p < 0.05$) than participants who did not (see @fig:s-total-by-wb-exp).
// #todo("effect size").
However, the performance difference between the two tools still remains, as participants with whiteboard tool experience still identified significantly fewer issues in pix:e than in Miro (Wilcoxon signed-rank test: $T = 97.5$, $p < 0.05$).
A similar effect can be observed for the F1 scores, as the median F1 score in pix:e is significantly higher (Mann-Whitney $U = 99.5$, $p < 0.05$) in participants who indicated previous whiteboard experience, see @fig:s-f1-by-wb-exp.
//F1 medians 0.25 and 0.285, Mann-Whitney
//#todo("effect size?")

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
This is supported by the Mann-Whitney U test (total issues: $U = 57.5$, $p approx 0.417$, F1: $U = 57.5$, $p approx 0.417$).// #todo("effect size?")

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
// - #todo("reference feedback")

==== Differences Between Groups <s-completion-by-groups>

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
There is no evidence for the distribution of total number of identified issues (see @fig:s-total-by-first-tool) in either tool differing based on which tool was used first (in pix:e: $U = 56.0$, $p approx 0.176$, in Miro: $U=  61.0$, $p approx 0.525$).
Also, participants still claimed significantly more issues in Miro than pix:e, regardless of which tool was used first (Miro first: $U = 113.5$, $p approx 0.007$, pix:e first: $U=109.5$, $p approx 0.014$).
However, for the F1 scores (see @fig:s-f1-by-first-tool), the tool order does seem to make a difference:
The pix:e-first group achieved higher median F1 score in both tools, with the difference being significant according to the Mann-Whitney U test (in Miro: $U = 34.5$, $p approx 0.013$, in pix:e: $U = 36.0$, $p approx 0.018$).
However, the difference in F1 scores between the two tools for the pix:e-first group remains significant (one-sided Mann-Whitney $U = 120.5$, $p approx 0.002$).
A potential reason for the higher F1 score in participants of the pix:e-first group is that those participants were introduced to the different issue types more thoroughly due to the explanation of the different highlighting options in pix:e.

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

==== Distribution of Issues Found Over Time

In order to estimate how efficiently participants were able to complete the task, this section analyzes how long it took participants to identify solvability issues.
The time it took each participant to identify their first issue was extracted from the timestamped data.
Additionally, an estimate of times spent to identify each issue was calculated as the delta between subsequent identified issues.
Both the initial timestamp and the calculated deltas may contain additional time spent on clarifications or comments.

#grid(
    columns: 2,
    inset: (x: 5pt, y: 5pt),
    grid.cell([#figure(
        image("assets/05/solvability-first-issue-events-hist.png"),
        caption: "Distribution of first issue found events across time"
    ) <fig:first-ife> ]),
    grid.cell([#figure(
        image("assets/05/solvability-first-issue-events-map-box.png"),
        caption: "Distribution of first issue found events across time by tool"
    ) <fig:first-ife-by-tool> ])
)

As visualized in @fig:first-ife, there is split in how long it took participants to identify a first issue in pix:e.
This seems to be caused by the different task variants: as seen in @fig:first-ife-by-tool, the time to first issue tends to be higher for task variant B.
While the task completion metrics were not distributed significantly differently between the four groups, the median number of total issues claimed was lowest for those assigned task B in pix:e (see @s-completion-by-groups).
This may be caused by task variant B being structured less clearly than its counterpart, as there is an early branching in the possible paths (see @dungeon-la4-miro, room 3).
In combination with the identified usability issues in pix:e (e.g., low contrast of nodes against the background, see @feedback-written), participants may have needed more time to orient themselves in the chart.

The estimated times it took participants to identify each issue are distributed relatively similarly across both tools and task variants (see @solvability-deltas-by-variant).

#figure(
    image("assets/05/solvability-issue-event-deltas-map-box.png"),
    caption: "Distributions of time deltas between issue found events by tool and task variant"
) <solvability-deltas-by-variant>

=== Results Pacing

This sub-section presents the results for the pacing analysis task in terms of task completion, again compared between the two tools and additional stratifications (such as previous experience of participants with whiteboard tools or the different user study groups).
//#todo("effect sizes")

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
They also gave significantly more correct answers (see @fig:p-right-by-wb-exp, Mann-Whitney $U = 103.0$, $p approx 0.017$).

There are some slight skews in median/distribution between the two tools: the number of answered questions tends to be higher in pix:e than Miro for participants who indicated experience with whiteboard tools, while both the total number of answered questions and the number of correct answers tends to be lower in pix:e than Miro for people who did not.
However, the differences in distribution do not seem to be statistically significant (Wilcoxon signed-rank test: $T = 38.0$, $p approx 0.326$ for total answers in pix:e vs Miro from participants with Whiteboard experience, $T = 15.0$, $p approx 0.207$ for total answers from participants without).

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
Again, 6 participants used additional functionalities in Miro. 1 participant changed sticky note colors to highlight specific nodes, 4 participants noted down calculations in textboxes, sticky note, or using the pen tool, and 1 participant recorded a valid path in a textbox.

The median of total answered questions and correctly answered questions in Miro skews lower for participants using functionality in Miro (see @fig:p-total-by-miro-usage and @fig:p-right-by-miro-usage), but not significantly so (Mann-Whitney test: $U = 32.5$, $p approx 0.0754$ for total answers, $U = 33.5$, $p approx 0.085$ for correct answers).
Additionally, the median for the total number of answered questions and the number of correctly answered questions is larger in pix:e than Miro for participants who did use Miro functionality.
The difference is however not statistically significant (Wilcoxon signed-rank test: $T = 11.0$, $p approx 0.1875$ for total answers, $T=13.5$, $p approx 0.297$ for correct answers)

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
Within pix:e, participants who indicated previous experience with whiteboard tools achieved better results than participants without.
Within Miro, participants using Miro functionalities even achieved slightly weaker results than participants not using Miro functionalities.

This points to a similar interpretation as in the solvability task:
pix:e likely caters better to power users.
Another insight is that Miro functionalities (without involved custom setup/templating) seem to be less suited to support users with this specific analytical task type, highlighting the need for a dedicated pacing analysis tool.

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
In Miro, the pix:e-first groups achieved significantly higher metrics compared to the Miro-first groups, both in terms of total answers (Mann-Whitney $U = 23.0$, $p approx 0.002$) and correct answers (Mann-Whitney $U = 39.0$, $p approx 0.027$).
In pix:e, there is no such difference (Mann-Whitney $U = 67.5$, $p approx 0.813$ for total answers, $U = 70.5$, $p approx 0.953$ for correct answers).

A possible interpretation may be that the visualizations provided by the diagrams allowed participants of the pix:e-first group to gain a better understanding of the data needed to answer the questions.
They may consequently have been better equipped to approach the task in Miro.

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

Analogously to the solvability task, this analysis inspects the results for any differences in task completion metrics between the two task versions.
As seen in @fig:p-total-a-vs-b and @fig:p-right-a-vs-b, both the distribution of total answered questions and the distribution of correctly answered questions skew lower for task variant B (dungeon LA_2).
For both distributions, the difference is statistically significant according to one-sided Wilcoxon signed-rank tests (total answered questions: $T = 176.0$, $p approx 0.004$, correctly answered questions: $T = 195.0$ $p approx 0.000$).
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

==== Distribution of Times Taken Per Answers

Analogously to the results of the solvability task, this section analyzes how long it took participants to answer questions to obtain an estimate for how efficiently participants were able to complete the task.
Based on the timestamps attached to answers, an estimate of times spent on each question was calculated as the delta between subsequent answers.
These deltas may contain additional time spent on clarifications or comments.

/*
#grid(
    columns: 2,
    inset: (x: 5pt, y: 5pt),
    grid.cell([#figure(
        image("assets/05/pacing-answer-events-hist.png"),
        caption: "Distribution of all answer events across time"
    ) <fig:all-ife> ]),
    grid.cell([#figure(
        image("assets/05/pacing-answer-event-deltas.png"),
        caption: "Distribution of deltas between answer events"
    ) <fig:first-ife> ])
)
*/

As seen in @answer-event-deltas-by-tool-and-map, the distributions of times participants took for each answer are overall comparable across tools and task variants.
The distribution skews a little higher for task variant B in pix:e.
This corroborates the insight based on the task completion metrics that task variant B may be more challenging.
However, in terms of tools, participants achieved similar, if not slightly better task completion metrics in pix:e.
One possible explanation considering the time deltas is that participants did not have to perform manual pathfinding in pix:e and therefore were able to consider the questions more thoroughly in pix:e.

#figure(
    image("assets/05/pacing-answer-deltas-by-variant.png"),
    caption: "Distributions of delta between answer timestamps by tool and map"
)<answer-event-deltas-by-tool-and-map>

=== Results UEQ-S

The UEQ-S consists of 8 items divided into 2 categories:
- Pragmatic quality ("relate to the tasks or goals the user aims to reach" #cite(<schreppDesignEvaluationShort2017>)) and
- Hedonic quality ("related to pleasure or fun while using the product" #cite(<schreppDesignEvaluationShort2017>))

Each item is a pair of opposing adjectives, and participants were asked to place StatePx on a 7-point scale between the adjectives.
This translates to a numeric scale ranging from -3 to 3.

The responses to the UEQ-S questionnaire were evaluated using the analysis tool provided by the authors #cite(<hinderksBenchmarkShortVersion2018>).
It provides mean scores for each item and rates the pragmatic, hedonic, and overall score against benchmark scores collected for Amazon and Skype.

#figure(
  image("assets/05/ueq-mean-value-per-item.png"),
  caption: "Mean values per item in the UEQ-S"
) <fig:ueqs-means>

@fig:ueqs-means shows the mean scores for each item, with the items measuring pragmatic quality colored navy and the items measuring hedonic quality colored yellow.
The fourth and weakest item is the pair "confusing vs clear".
This relatively low (albeit positive) score is in line with participant feedback, which included a number of UI issues (@feedback-written).

Judging the scores against the provided benchmark, the pragmatic quality is rated _below average_ (i.e. better than 25% of benchmark) with a mean of 0.823, the hedonic quality is rated _good_ with a mean (i.e. better than 75% of benchmark) of 1.385, and the overall score is considered above average (i.e., better than 50% of benchmark) with a mean of 1.104.

#figure(
  image("assets/05/ueq-against-benchmark.png"),
  caption: "Comparison of UEQ-S scores against benchmark"
)

//#todo("control for whiteboard experience?")

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
For last question however, participants who indicated previous experience with whiteboard tools indicated a particularly strong preference for pix:e as seen in in @cq4-wb-exp (median 5 in participants with, 4 in participants without).
Answers for the first three questions may be divided because on one hand, these participants may be more used to a Miro-like UI and thus more comfortable using Miro, but on the other hand, they may also be better equipped to recognize the advantage of a dedicated tool compared to a generic whiteboard tool.

#figure(
  image("assets/app/c-q4-by-wb-exp.png", width: 50%),
  caption: "Distribution of answers to C-Q4 from participants with (1) and without (0) indicated whiteboard tool experience"
) <cq4-wb-exp>

=== Written Feedback from Participants <feedback-written>

Written freeform feedback was collected once after the first part of user study (see Task 1 in @app-us-tasks), and once at the very end of study.
The complete answers are presented in the appendix (@app-written-feedback).
Each answer is assigned a tag, which is used here to refer to specific answers.
This section describes the feedback specific to the features implemented as part of this thesis.

In terms of UI and usability, participants noted the following points.
5 participants reported confusion about how to add locks due to the menu placement (FQ1-A3, FQ1-A9, FQ1-A10, FQ1-A17, FQ1-A20).
This was to be expected as the current UI is only a workaround.
3 participants suggested that keys should be included in the node context menu (FQ1-A4, FQ1-A5, FQ1-A12).
Especially in the zoomed out view, 4 participants found the contrast between background and nodes to be too little (FQ2-A4, FQ2-A5, FQ2-A8, FQ2-A13), and 3 participants criticized a missing level of detail (FQ2-A9, FQ2-A11, FQ2-A15).
1 participant reported accidentally moving nodes while panning (FQ2-A9). 
Another participant expressed confusion about the diagram tick labels (FQ2-A2), as with longer paths, only every second node was labeled on the x axis.
5 participants mentioned that locks should be visually distinguishable (FQ2-A0, FQ2-A3, FQ2-A5, FQ2-A12, FQ2-A15)

Additionally, some participants (e.g., FQ1-A13) reported confusion about the fact that bombs were modeled using keys.
This is however not an issue with the implemented features, but rather a modeling decision.

With regards to functionality, 3 participants suggested specific functions for calculating sums and averages in diagrams (FQ2-A2, FQ2-A5, FQ2-A15).
One participant desired more general interactivity in diagrams (FQ2-A7), likely to analyze specific sections of a path more closely (e.g., by zooming in on specific parts).
As for the pathfinding and solvability features, two participants found the highlighting insufficient as feedback (FQ2-A6, FQ2-A14), and two expressed a desire for more details about intermediate states during pathfinding (FQ2-A10, FQ2-A14), including analyzed paths and which keys may be available in each node.

=== Observed Behavior and Verbal Feedback from Participants <observed-verbal>

In addition to the written feedback collected from participants directly, the study protocols include valuable observations about how participants used pix:e and verbal comments from participants.
As these protocols were created manually while conducting the study, they may be incomplete or slightly inaccurate.
However, they still offer some further insight into how participants used pix:e.
The full list of notes is provided in @app-protocol-observations and summarized in this section.

5 participants required clarification that all locks were visualized by the same symbol.
4 of those participants completed the task in Miro first, thus may have been primed to expect similar visualization.
This issue was also mentioned multiple times in the written feedback.

10 participants performed a reachability analysis in pix:e by way of successive pathfinding, i.e., selecting different target nodes for the given start node.
This corroborates the written feedback about providing more insight into which paths were explored during pathfinding.

Lastly, 3 participants (all in Miro-first groups) asked whether enemies respawn for the pacing task.
While this was indeed unclear from the task description, it is still notable that only Miro-first participants considered the option that enemies may not respawn. The pacing diagrams in pix:e always show values for nodes that occur multiple times on a path.
This may have primed pix:e-first participants to understand the respawn implicitly and apply the same principle in Miro.
/*
=== Validity of A/B Test

- compare results across groups -> statistical test? (ANOVA for 3+ groups)
- compare demographics across groups
*/

== Limitations

A main limitation of this study is that time constraints prohibited a proper pilot study, which may have given insight into the more glaring usability issues and differences between task versions.

Additionally, as mentioned previously, the manual data processing methods may have resulted in minor errors in the analyzed data.

Lastly, not all functionality was included in the study (e.g. soft gates, creation of component/lock/key definitions, plotting values against play time).

== Post-Study Improvements

After an initial assessment of the collected data and feedback, one round of improvements was implemented to address a number of issues that were both common and reasonably simple to fix.

This subsection describes the implementation strategy and outcome for each of the improvements.

=== Improved Visual Representation of Locks & Keys

In the initial evaluated version, all lock assignments on edges were represented by the same symbol.
A notable number of participants explicitly mentioned that distinct visualization of different lock types would improve the experience or expressed confusion during the tasks due to the initial representation.

Emojis were chosen as the improved visual representation due to their wide range of options and expected familiarity of users with the available symbols.
The original data model was extended by a `symbol` attribute for both locks and keys.
Symbols can be selected via an emoji picker when creating or editing definitions.
The default values are a lock emoji (🔒) for lock definitions and a key emoji (🔑) for key definitions.

In the chart view (see @improved-symbols-chart), key assignments are now represented using the symbol, with a tooltip showing the name of definition on hover.
Edges show the symbols of all assigned locks as their label, including their multiplicity.
As edge tooltip are not native in the current framework, a legend popover was implemented instead to assist users in understanding the visual representation.

#figure(
    image("assets/05/pixie-improved-symbols-in-chart.png"),
    caption: "Improved visual representation of locks and keys in chart"
) <improved-symbols-chart>

The legend is located in the bottom right corner of the chart and can be shown or hidden via a button.
It shows an overview of available lock and key definitions in separate tabs (see @improved-legend-locks and @improved-legend-keys), including notable features for each definition (e.g. symbol, name, consumable for keys, unlocking key definitions for locks).

#grid(
    columns: 2,
    align: bottom,
    grid.cell([
        #figure(
            image("assets/05/pixie-improved-symbols-legend-locks.png", width: 75%),
            caption: "Legend of lock types, including unlocking keys"
        ) <improved-legend-locks>
    ]),
    grid.cell([
        #figure(
            image("assets/05/pixie-improved-symbols-legend-keys.png", width: 75%),
            caption: "Legend of key types, including key type and whether they are consumable"
        ) <improved-legend-keys>
    ]),
)

To align the visual representation of lock and key types throughout the player experience module, the symbols were also included wherever definitions were referenced, in particular in the assignment creation modals.

#grid(
    columns: 2,
    align: bottom,
    grid.cell([
        #figure(
            image("assets/05/pixie-improved-symbols-edit-locks.png", width: 75%),
            caption: "Lock assignment creation modal with symbols"
        ) <improved-modal-locks>
    ]),
    grid.cell([
        #figure(
            image("assets/05/pixie-improved-symbols-key-creation.png", width: 75%),
            caption: "Key assignment creation modal with symbols"
        ) <improved-modal-keys>
    ]),
)

=== Reachability Analysis

A notable number of participants were observed to conduct a reachability analysis during the solvability task on their own (10 participants, see @observed-verbal).

Implementation of this improvement is straightforward as the underlying Dijkstra algorithm already performs an implicit reachability analysis.
In particular, it tracks distances of nodes from the start nodes, with the initial value being `Infinity`.
Consequently, all nodes with distance < `Infinity` after the algorithm has concluded are reachable and can simply be filtered for.

In case of failed pathfinding, unreachable nodes are then highlighted (see @improved-reachability).
// #todo("confirm/wait for julian's pr feedback")

#figure(
    image("assets/05/pixie-improved-reachability-analysis.png", width: 50%),
    caption: "Improved visual feedback about reachability on failed pathfinding (LA_3 as example)"
) <improved-reachability>

=== Increased Contrast of Nodes Against Background

6 participants reported the low contrast between nodes and background as a usability issue, especially when zoomed out (see @feedback-written).
This issue was remedied by adding a dedicated background color in the CSS theme (see @improved-contrast).

#figure(
    grid(
        columns: 2,
        inset: 5pt,
        image("assets/05/pixie-improved-contrast-light.png", width: 90%),
        image("assets/05/pixie-improved-contrast-dark.png", width: 90%)
    ),
    caption: "Increased contrast due to adjusted background color in both light and dark modes"
) <improved-contrast>

#load-bib()