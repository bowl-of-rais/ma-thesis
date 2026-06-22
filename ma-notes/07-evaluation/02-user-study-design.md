---
start: 2026-05-27
end:
tags:
milestone:
---

- [/] formulate hypothesis/goal 🛫 2026-05-27
- [/] determine number and target group of participants
- [/] decide on study setup: method, type of study, ... 🛫 2026-05-27
- [/] draft user study protocol
	- [/] questionnaires
	- [/] tasks
	- [/] collected data
- [ ] refine user study ⏳ 2026-06-23 
- [/] figure out timeline

---

## Hypothesis/Goal

- new features (diagrams, locks and keys) make the game design process easier
	- baseline:
		- ~~pix:e without these features~~~
		- Miro

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

- demographic data:
	- age, gender
	- education level
	- profession
	- game design experience

- screen recordings
	- intermediate and final configurations/tool states
- task completion time
- retries/attempts? -> would need clear definition of what an attempt is

- subjective assessment of users
	- "I would imagine these tasks to be easier with a dedicated tool/harder with a generic whiteboard tool"
	- ...
- questionnaire (e.g. SUS)

- ~~think-aloud~~
- ~~(maybe) log data -> would need to improve logs to get maximum information~~
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

- more high-level, 1 chart = 1 game (e.g. Life Is Strange)

- [0] tutorial: get participants used to tool

- [1] let users build chart
	- give nodes to arrange in order
	- e.g. increasing difficulty, combined scores, paths with different learning curves
- [2] give finished chart
	- have users answer questions
		- MC
	- have users modify it for different requirements

#### Task 2: Locks and Keys

- more lower-level, 1 chart = 1 level (e.g. Zelda Dungeon, Detroit Become Human)

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

---

- idea for recruitment: social computing lecture

---

## Pre-Task Questionnaire

- age
- gender
- education level
- profession
- experience with game design/development (split into two?)

## Task Design

- [?] fictional games to reduce bias
- limitation: only two specific use cases (study time constraint)

### Diagrams Tasks

#### Topics

- difficulty course/learning curve
- level type variety
- estimated playtime

#### Question Types

>All/Some, but not all/No paths to the boss level contain X.

>There is a/no path from A to B with feature Y.

>The game has/does not have a (steep) learning curve.

>There are different ways of varying difficulty to beat this game./All ways of beating this game have similar difficulty.

-> with stacked bar chart?:

>There is little/a lot of variety of level types along all gameplay paths.

>There is a similar amount of variety of level types along different gameplay paths.

### Locks and Keys Tasks

#### Chart Types

- [@summervilleVGLCVideoGame2016]: dataset of Zelda Dungeons -> use to approximate complexity
	- avg number of nodes: **33** (12-66)
	- avg node degree: **2.2** (1.8-2.75)
	- avg number of keys: **6.8** (3.0-13.0)
	- avg number of locks: **14.5** (2.0-32.0)

(see code for analysis)

-> depending on study setup: small, medium, large

**small**: ~12 nodes, 3 keys, 4 locks -> also for tutorial
**medium**: ~24 nodes, 8 keys, 16 locks
**large**: ~48 nodes, 13 keys, 32 locks

- [r] after trying out: more like 24 max (zoom level/usability, readability)

(not too large, manual analysis should be feasible in limited time)

- [?] fixed lock/key definitions? limit to reduce variables

- [i] node names neutral (alphabetic), *not* in order of path

- [?] node previews instead of detailed views?

#### Question Types

>Find a path from start to end. Make sure any keys necessary to unlock the edge are collected on the way to the respective edge.

>Does this chart contain soft locks? If yes, modify it to prevent any softlocks without removing locks.

(limitation: only in paths to goal)

>Can this level be beat? If no, modify it to make it possible/Find three different ways to make it solvable.

>Add keys to rooms to make this puzzle solvable. Use as few keys as possible.

## Post-Task Questionnaire

[@brookeSUSQuickDirty1996]
![[Pasted image 20260622233459.png]]

---

potential extensions:
- stacked bar chart for strings components
- visualization of keys in diagrams
