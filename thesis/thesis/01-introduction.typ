#import "../utils.typ": todo
#import "../bib.typ": load-bib

= Introduction <intro>

#todo("Hook (Optional): What makes the problem exciting for the reader?")

#todo("Motivation: Why did you study the problem?")
#todo("short sentence about what game design entails")
Player experience and pacing are two concepts that revolve around how players interact with a game over its course.
By considering player experience during the game design process, #todo("add reason why considering player experience is important").

pix:e is a web-based, research-backed toolkit for game designers with a focus on player experience.
The main goal of this thesis is to expand pix:e's capability to model player experience and pacing via statecharts and allow its users to better capture and analyze relevant data during the game design process.

Concretely, the two research questions central to this work are:

// RQ1: Which data would be interesting?
/ RQ1: How can pix:e's player experience module be extended to model relevant data?
// RQ2: Which analysis of the data is interesting?
/ RQ2: Which analysis of said data is interesting and/or helpful?

#h(1.8em)
To this end, this thesis makes the following contributions:

- Path-based pacing diagrams in pix:e #footnote[Code available at #link("https://github.com/gamedevlabs/pix-e")] <repo-pixie> (@impl-diagrams)
- Modeling of lock-and-key puzzles and related solvability analysis in pix:e @repo-pixie (@impl-lk)
- User study to evaluate implemented features and identify gaps #footnote[Data and Evaluation available at #link("https://github.com/gamedevlabs/user-study-data-pathfinding")] <repo-eval> (@eval)

#todo("move data to repo")

#load-bib()