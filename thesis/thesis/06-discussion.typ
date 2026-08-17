#import "../utils.typ": todo
#import "../bib.typ": load-bib

= Discussion <id>

The goal of this research was to identify and implement features that improve pix:e's ability to support game designers in modeling player experience.
This was done by implementing a basic version of pacing diagrams and capabilities for modeling and verifying lock-and-key puzzles, both based on a pathfinding functionality that is able to account for locks and keys.

/*
context: player experience module -> more generalized approach, implemented functionalities can be used to model gameplay as well (-> user study).
as mentioned in PaceMaker #cite(<geheebPaceMakerPracticalTool2024>): artifact parameters, which influence player experience.
an argument is to be made that the two aspects should be considered hand-in-hand: locks and keys are used to model conditions that affect how players move through the modeled experiences.
explicitly modeled gameplay could be used to predict player experience.
*/

== Feature Selection and Implementation

Pacing diagrams were already found to be of interest in the evaluation of PaceMaker #cite(<geheebPaceMakerPracticalTool2024>), thus being an obvious answer to the question of which analysis functionalities should be included in StatePx.

With the addition of locks and keys, `PxCharts` provide much more flexibility regarding how to model game structures.
Solvability of lock-and-key puzzles is intertwined with pathfinding, which makes it a priority in terms of analysis features as the pathfinding functionality is fundamental to the pacing diagrams as well.
Due to the intricacies of different lock and key types, solvability analysis also has obvious merit.

As the pathfinding, the pacing diagrams, and the functionalities around locks and keys were all new contributions to pix:e, the implementation includes a lot of groundwork.
However, especially for pacing diagrams, this was approached with a focus on extendability and flexible design so the initial version could be built upon and expanded in the future.
Many possible improvements and extensions were already identified during implementation, but could not be realized due to time and/or framework constraints.

== Evaluation

The focal point of the evaluation was a comparison of pix:e/StatePx to Miro.
While pix:e offers functionalities and logic specific to the chosen use cases,
Miro's UI and tooling is more mature, allowing for a clearer visual representation of statecharts. 

In the solvability task, participants generally performed better in Miro.
This is likely due to the visual distinction between different lock types as understanding the placement of locks is a central prerequisite of solvability analysis.
As for the pacing analysis task, task completion metrics were found to be similar between the tools.

In both tasks, participants who indicated previous experience with whiteboard tools achieved significantly better task completion metrics in pix:e than other participants.
This user group may be better equipped to leverage pix:e's features, a positive insight being that users currently using general-purpose tools for game design are likely to be interested in pix:e's analytical capabilities and thus willing to switch tools.

Within Miro, the use of its built-in functionalities did not seem to support participants in achieving better results.
Miro seems to be mainly well-suited for _modeling_ player experience in statecharts, but less so for analyzing it.
Another perspective that could be taken is that in spite of the existing UI issues, the analysis functionalities integrated in StatePx allowed participants to complete the pacing analysis task just as well.
With the necessary UI improvements, pix:e therefore has the potential to be a very powerful pacing analysis tool.
//The results also support future efforts to incorporate whiteboard-like approach (Miro's strengths) into StatePx. 

Additionally, the metrics explored as part of the evaluation differed between the two variants for each task.
This points to the fact that despite the effort to design task variants with similar complexity, they were not fully comparable.
This may have been prevented by conducting a pilot study, which was not possible due to time constraints.
 
The subjective assessment of StatePx by participants was found to be positive, as evidenced by the high hedonic quality in the UEQ-S score and indicated preference for pix:e over Miro.
In the collected feedback, participants generally expressed excitement about the potential of the tool.
It also provided many meaningful pointers for possible improvements, some of which were already implemented.

Overall, the user study provided a conclusive overview of the strengths and weaknesses in pix:e's current ability to analyze player experience and pacing.

#load-bib()