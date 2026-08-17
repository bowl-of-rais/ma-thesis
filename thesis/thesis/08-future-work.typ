#import "../utils.typ": todo
#import "../bib.typ": load-bib

= Future Work <id>

Based on the implementation described in @impl-diagrams and @impl-lk and the evaluation described in @eval, this section details future work that may improve the system's functionalities and advance the associated research. 

== UI/UX

Based on user study participant feedback (see @feedback-written),  easier editing of both component/key assignments and edges is a central point for future improvement.
Particularly, the creation of key assignments should be added to the node context menu.
For edge-related editing functionalities (specifically assigned locks and directionality, but also deletion), a context menu would likely be preferable to the current setup.
Using the VueFlow library, such a context menu could be simulated using a custom edge type.

Another UI-related aspect that could be improved upon is the feedback provided by the pathfinding and/or solvability analysis.
One participant specifically suggested adding information about the intermediate states during pathfinding.
This may e.g. translate to an overlay providing additional information regarding the solvability analysis.
Helpful information might include the maximum set of keys that each node could be visited with, or the distance of each node from the start node.
Additionally, as mentioned in @impl-lk, the highlighting and general visualization of paths involving backtracking could be improved to better communicate at which points backtracking occurs.

Another observation #todo("reference") was that on occasion, participants moved nodes accidentally while panning and exploring the chart.
One way to addess this issue would be to introduce different modes of interacting with the chart (e.g., "Edit Mode" and "Analysis Mode"), thus making the editing/moving of nodes and the pathfinding mutually exclusive.
By disabling path calculation in an edit mode, the node selection functionality would also be available for bulk edits.

== Existing Functionalities

Concerning the functionalities implemented as part of this work, there are a number of smaller possible extensions that are either apparent gaps in the current state of the system or easily implemented.

As mentioned in @impl-diagrams, the diagram generation functionality currently only supports line diagrams, but should be easily extensible to other diagram types.
A possible other visualization as implemented in PaceMaker are stacked bar charts for categorical (i.e., textual) data.
Boolean data could either be mapped to numerical values or, when visualized with other data types, be represented by different point shapes (e.g., circles vs squares).
To filter for meaningful components in the selection for the x-axis, `PxComponents` could be extended by a flag that indicates whether a component corresponds to either of play or event time. 
Overall, the flexibility of `PxComponent`s results in a variety of possible visualizations. 
Further investigation is needed to determine how this high degree of customizability is best translated into a diagram configuration UI.

Compared to the original PaceMaker system, pix:e also lacks the ability to take path snapshots or save paths.
Given such a functionality, the system could then be extended to assign different snapshots to different diagrams to allow for an easier comparison of pacing along different paths.
In the same vein, persisting diagrams would enable users to consistently analyze their data over the course of a project.

Feedback from user study participants also suggested a need for simple data analysis functionalities in the diagrams, such as the display of sums or averages, though this may be rather specific to the use case modeled in the pacing analysis task (see @feedback-written).
Another observation from the user study was that in some use cases, component values may change when re-visiting nodes (e.g. enemies that respawn vs ones that don't).
This indicates a need for a component-specific setting or attribute that allows users to model components more dynamically.
However, such a setting may not generalize meaningfully to all concepts that components model.

With regards to the lock and key-related functionalities, there are further lock/key variants that are yet to be integrated into pathfinding, including fixed keys and different unlock modes (see @impl-lk).

== Additional Functionalities

//#todo("think of something for diagrams?")

Based on the current state of StatePx, there are several features that are complementary to the existing functionalities and could extend the system's capabilities to better assist game designers.

To facilitate solvability analysis, a path-agnostic check could be added that, given a specific start node, checks for any solvability issues or unreachable nodes.

For lock-and-key puzzles specifically, additional analysis functionalities could include a difficulty estimation for the puzzle 
//#todo("add citation")
or recommendations for the placement of lock and key types #cite(<dormansCyclicGeneration2017>).

Finally, there are multiple ways in which the existing analysis functionalities could be expanded upon using large language models (LLMs).
//pix:e already offers multiple LLM-based features, consequently, the integration of LLMs into the analysis features should be uncomplicated.
//#todo("connect")
Firstly, LLMs could assist in modeling by creating definitions for components, locks, and keys based on prompts or corresponding assignments based on node descriptions.
//In the same vein, LLMs could be used to verify existing assignments on consistency against node's descriptions.
LLMs may also be helpful in bridging the gap between modeling artifact and experience parameters by suggesting values for either type of parameter based on the other.
Lastly, LLMs could be used to generate textual analyses regarding pacing along paths. 

== Internals

Path calculation, especially including locks and keys, may become arbitrarily complex #todo("citation").
In the current implementation however, it is fully performed in the frontend.
In order to improve performance, an optimized implementation may be added in the backend.
The aforementioned path snapshot functionality could be designed in such a way that allows the path calculation to leverage previously computed paths to reduce the computational load.

Additionally, the implementation could be made more robust by way of unit testing and benchmarking.

== Evaluation

In terms of evaluation, some features were intentionally left out of the evaluation as they were not the focal point of this work.
Examples include the creation of definitions and some analysis features, e.g. soft gates, or diagrams with sums along the x-axis.
A dedicated evaluation of these feature would be able to assess the user experience more holistically and point to potential issues specific to those features.

In light of the steeper learning curve as reported by some study participants, an extended user study where the system is used and evaluated over a longer amount of time may more accurately assess how well the system and the features contributed by this thesis support the game design process.


#load-bib()