#import "../utils.typ": todo
#import "../bib.typ": load-bib

= Approach <prop_methods>

== Original Pacemaker Functionality

After familiarizing myself with the existing codebase, the first step will be to port the original pacemaker functionalities. This includes basic path selection and corresponding intensity/gameplay category diagrams, as well as automatic calculation of some experience parameters #cite(<geheebPaceMakerPracticalTool2024>). 

== Extend Diagram-Based Analysis

=== Path Selection

In the long run, the diagram should be extended to include path selection with concurrency and nestedness. While the implementation of this might not end up being part of my thesis, the software architecture and any changes I make should be extendable in that regard.

=== Lock/Key Dynamic

One big feature will be the analysis of lock/key dynamics and skills requirements. The basis of this will be the incorporation of locks/keys in the existing diagrams and the path selection functionality. The latter requires implementation of a specialized pathfinding algorithm like the one proposed by #cite(<aversaPathPlanningInventoryDriven2015>, form: "prose"). The path selection would already offer a feasibility test, i.e. whether the lock/key puzzle is even solvable. Other approaches for useful analyses might be a challenge/entertainment rating #cite(<fontConstrainedLevelGeneration2016>) or similarity checks that could help prevent potentially boring repetitions.

=== LLM-based evaluation

As pix:e already includes some LLM-based features, it could be easily extended to offer LLM-based evaluations along paths. Some ideas for this kind of analysis would be a narrative summary or the extraction of experience parameters from beat descriptions.

=== Potential Further Extensions

There is a time buffer to account for further promising extensions. This includes the functionality of px components or other artifacts.

== Evaluate

One way to evaluate the extended functionalities would be a user study. The details of how to best conduct it are yet to be determined. 


#load-bib()