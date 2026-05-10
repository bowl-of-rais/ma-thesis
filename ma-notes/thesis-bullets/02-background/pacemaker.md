[@geheebPaceMakerPracticalTool2024]

- PaceMaker: predecessor of PxCharts

>The toolkit, PaceMaker, allows the user to design a non-linear experience chart and subsequently plot relevant information like intensity or gameplay category of each node along a path on the chart.

-> presented as prototype/PoC

### About Pacing

>Pacing describes the rhythm that results from the recurring patterns of rhythmic parameters in time. Rhythmic parameters are divided into artifact and experience parameters.

-> mostly numerical or categorical

### About PaceMaker

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

### Results and Evaluation

![[Pasted image 20260123113505.png]]

- comparison of different properties per beat
- comparison of different paths

TODO

### Discussion

- usability issues
- nesting/concurrency
