#import "../utils.typ": todo
#import "../bib.typ": load-bib

= Introduction <prop_intro>

== Context/Motivation

Usability is a crucial, yet often underprioritized aspect of software development. There are different factors that contribute to usability, such as users' understanding of a software's capabilities, or how easy it is to utilize those capabilities. In short, good usability of a software means that it can be used effectively and easily. Usability belongs to the broader subject of user experience (UX), which for instance also includes how engaging a software is for users. The topic of usability is also related to accessibility, which focuses more on whether software can be used by people regardless of factors like age or ability.

== Thesis Goal/Research Questions

The main focus of my thesis are going to be the research and implementation of maintainable, effective, and research-backed principles of usability and accessibility. This includes both established guidelines and state-of-the-art findings.

The software this thesis will work on is pix:e, a toolkit for video game developers @geheebPaceMakerPracticalTool2024. Specific aspects of this software to consider are the open-source context of the software, the NLP-based features, and the technical background of the intended user base.

With this context, the aim will be to answer the following research questions:

- RQ1: How can different approaches/methods to evaluating and implementing usability be combined?
- RQ2: How impactful are different usability features in the context of pix:e's domain?

The first question will be addressed by a literature review and usability audit. Based on the results, selected usability features will be implementated. For the second question, the aforementioned improvements will be evaluated in a user study.


#load-bib()