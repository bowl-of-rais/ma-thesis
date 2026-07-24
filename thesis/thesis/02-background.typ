#import "../utils.typ": todo
#import "../bib.typ": load-bib

= Background <backg>

== PaceMaker

#cite(<geheebPaceMakerPracticalTool2024>)

- PaceMaker: predecessor of PxCharts

"The toolkit, PaceMaker, allows the user to design a non-linear experience chart and subsequently plot relevant information like intensity or gameplay category of each node along a path on the chart."

-> presented as prototype/PoC

"Pacing describes the rhythm that results from the recurring patterns of rhythmic parameters in time. Rhythmic parameters are divided into artifact and experience parameters."

-> mostly numerical or categorical

=== Functionalities and Evaluation of PaceMaker

1. statecharts for modeling [@harelStatechartsVisualFormalism1987]
	- nodes = beats
2. experience specification: properties that can be assigned to a beat
	- name, description, narrative/gameplay/overall intensity, gameplay category, expected playtime
	- in p:xe: PxComponents, can be defined by user (available datatypes: TODO)
3. path selection
	- start/intermediate/end beats -> Dijkstra
	- path snapshots
	- implementation in p:xe part of this work
4. pacing diagrams
	- visualize intensity or gameplay category per beat
	- in p:xe: selection based on PxComponents
  - comparison of different properties per beat
  - comparison of different paths


- usability issues
- nesting/concurrency

== Lock-and-Key Puzzles

#cite(<ashmoreQuestGeneratedWorld2007>)
"The puzzle is finding out what is an obstacle, what and where is a key to overcome it, and finally using the key to master the challenge."

#cite(<ashmoreQuestGeneratedWorld2007>)
"Obstacles may not be passed until the player obtains some token (such as an item or skill)"

-> keys as abstract tokens more than literal items

== Game Design?? Level Design??


#load-bib()