#import "../utils.typ": todo
#import "../bib.typ": load-bib

= Discussion <id>

goal of research: identify and implement features that improve pix:e's ability to support game designers

context: player experience module -> more generalized approach, implemented functionalities can be used to model gameplay as well (-> user study).
as mentioned in PaceMaker #cite(<geheebPaceMakerPracticalTool2024>): artifact parameters, which influence player experience.
an argument is to be made that the two aspects should be considered hand-in-hand: locks and keys are used to model conditions that affect how players move through the modeled experiences.
explicitly modeled gameplay could be used to predict player experience.

== Implementation

lots of groundwork with focus on extendability and flexible design -> hopefully solid basis to build upon

#todo("potential bugs")

many possible improvements and extensions already identified during implementation

one round of improvements done after user study to address common criticisms

limited by time constraints and framework

== Evaluation

methodology: no pilot study. 
#todo("validity A/B test") #todo("limitations")

comparison: pix:e has more dedicated functionality + logic, but ui is less mature (zoomed out view, editing features).
emoji encoding in Miro.

summary of results: no clear advantage in task completion in pix:e, though it did produce better results for participants who indicated previous experience with whiteboard tools for both tasks.
high hedonic quality in UEQ-S and preference for pix:e over Miro for the presented tasks.
freeform feedback provided many meaningful pointers for possible improvements, some of which were already implemented, and generally expressed excitement about the potential of the tool.
possible explanation/interpretation: tool better suited for power users (extrapolated: people familiar with tool-supported game design).
in line with feedback regarding the tool having a learning curve -> may be easier to use when building on pre-existing knowledge. but also, when thinking about target users, this may be an additional incentive for Miro users to switch.
another perspective: in spite of UI issues, participants were able to achieve similar results in the pacing analysis task.

overall user study gave good pointers for how to further develop the system.
learning curve expected for specialized tools? #todo("check if supported by literature")

#load-bib()