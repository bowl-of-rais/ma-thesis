#import "../utils.typ": todo
#import "../bib.typ": load-bib

= Introduction <intro>

Digital games live at an intersection of software and narrative media.
As such, they allow players to experience stories in a uniquely interactive way. 
One crucial aspect in creating and enjoying narrative media is its emotional impact. #cite(<elsonMoreStoriesButtons2014>)

This is just one of the aspects subsumed under player experience, which generally describes how players receive a game from an emotional and psychological standpoint #cite(<wiemeyerPlayerExperience2016>).
Relatedly, pacing is a concept that revolves around how players' interaction with a game affects player experience over time #cite(<bagusharisaPacingbasedProceduralDungeon2022>).
By considering these two aspects during the game design process, game designers can better create the intended experience for players #cite(<haiderMiniPXIDevelopmentValidation2022>).

pix:e is a web-based, research-backed toolkit for game designers.
One core functionality of pix:e is modeling player experience, i.e., it allows game designers to map out player experience throughout a game's progression.

The main goal of this thesis is to expand pix:e's capability to model player experience and allow its users to better capture and analyze relevant data during the game design process.

Concretely, the two research questions central to this work are:

// RQ1: Which data would be interesting?
- RQ1: How can pix:e's player experience module be extended to model relevant data?
// RQ2: Which analysis of the data is interesting?
- RQ2: Which analysis of said data is interesting and/or helpful?

//#h(1.8em)
To this end, this thesis makes the following contributions:

- Path-based pacing diagrams in pix:e #footnote[Code available at #link("https://github.com/gamedevlabs/pix-e")] <repo-pixie> (@impl-diagrams)
- Modeling of lock-and-key puzzles and related solvability analysis in pix:e @repo-pixie (@impl-lk)
- User study to evaluate implemented features and identify gaps #footnote[Data and Evaluation available at #link("https://github.com/gamedevlabs/user-study-data-pathfinding")] <repo-eval> (@eval)

#load-bib()