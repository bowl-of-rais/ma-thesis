#import "../utils.typ": todo
#import "../bib.typ": load-bib

= Introduction <intro>

#todo("Hook (Optional): What makes the problem exciting for the reader?")

#todo("Motivation: Why did you study the problem?")

- game design tools -> pix:e.
- pacing analysis and solvability issues

#todo("Problem Statement: What problem are you trying to solve?")
pix:e is a toolkit for game designers with a focus on player experience.
The main goal of this thesis is to expand the statechart feature in pix:e's player experience module and its capability to capture and analyze relevant data during the game design process.

Concretely, the two research questions central to this work are:

/ RQ1: Which data would be interesting?
/ RQ2: Which analysis of the data is interesting?

#h(1.8em)
To this end, this thesis makes the following contributions:

- Path-based pacing diagrams in pix:e #footnote[Code available at #link("https://github.com/gamedevlabs/pix-e")] <repo-pixie> (@impl-diagrams)
- Modeling of lock-and-key puzzles and related solvability analysis in pix:e @repo-pixie (@impl-lk)
- User study to evaluate implemented features and identify gaps #footnote[Data and Evaluation available at #link("https://github.com/gamedevlabs/user-study-data-pathfinding")] <repo-eval> (@eval)

#todo("move data to repo")

#load-bib()