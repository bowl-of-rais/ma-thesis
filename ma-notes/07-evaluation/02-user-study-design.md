---
start: 2026-05-27
end:
tags:
milestone:
---

- [/] formulate hypothesis/goal 🛫 2026-05-27
- [ ] determine number and target group of participants
- [/] decide on study setup: method, type of study, ... 🛫 2026-05-27
- [ ] design user study protocol
	- [ ] questionnaires
	- [ ] tasks
	- [ ] collected data
- [ ] figure out timeline

---

## Hypothesis/Goal

- new features (diagrams, locks and keys) make the game design process easier
	- baseline:
		- pix:e without these features
		- compared to other processes

## Participants

- target group of tool: game designers/developers -> niche
- recruitment:
	- game design students
	- computer science students with interest in games/hobby game designers?
	- ...

## Study Setup

- summative/confirmatory

#### Options

- quantitative vs qualitative
	- quantitative, if possible

- within subjects or between subjects
	- trade-off: within-subjects has risk of learning effect and takes more time per participant,
	- between subjects needs more participants

- [i] time frame per participant: 30-45 min

breakdown:
- 5 min intro
- 10 min tutorial
- 10 min task
- 10 min post-task questionnaire

#### Brainstorm: What Data to Collect?

- screen recordings
	- intermediate and final configurations/tool states
- task completion time
- retries/attempts? -> would need clear definition of what an attempt is
- subjective assessment of users
- questionnaire (e.g. SUS)
- think-aloud
- (maybe) log data -> would need to improve logs to get maximum information
	- naive approach: log all user inputs
	- how to measure in control (Miro)?

- [r] time constraint: collect as much data in parallel as possible -> need multiple ways/mediums

## Study Design

- [i] details may depend on state of tool at point of time
- [i] should be fictional game to reduce biases/avoid spoilers? 

### Tasks

#### Baseline

- comparison with Miro?
	- harder to get comparable data probably
- pixe with diagrams/pathfinding disabled #future_work 
	- might be useful to evaluate inherent difference between Miro/Pixe

#### Task 1: Diagrams

- [0] tutorial: get participants used to tool

- [1] let users build chart
	- give nodes to arrange in order
	- e.g. increasing difficulty, combined scores, paths with different learning curves
- [2] give finished chart
	- have users answer questions
		- MC
	- have users modify it for different requirements

#### Task 2: Locks and Keys

- [0] tutorial: get participants used to tool

- [1] ask to create max complex chart with time limit and constraints (path must exist, no softlocks)
	- nothing keeps people from making simpler charts lmao
- [2] give chart with locks/keys to modify
	- ensure no softlock
	- ensure no deadlock
- [3] give chart to populate with locks/keys
	- would benefit from functionality of in-chart editing of nodes
- [4] give chart to correct

### Measurements

- task completion speed
- result accuracy/quality


---

- [?] setting: in-person?
- [?] medium to give tasks -> pdf? paper?
- [?]  
