#import "../utils.typ": todo
#import "../bib.typ": load-bib

= User Study Data <app-us-data>

== Results of Comparative Questions by Whiteboard Experience <app-cq-by-wb-exp>

The following plots visualize the answer distributions to the four questions comparing Miro to StatePx stratified by indicated whiteboard experience on a shared y-axis.

#figure(
  image("assets/app/c-q1-by-wb-exp.png"),
  caption: "Distribution of answers to C-Q1 by indicated whiteboard tool experience"
)

#figure(
  image("assets/app/c-q2-by-wb-exp.png"),
  caption: "Distribution of answers to C-Q2 by indicated whiteboard tool experience"
)

#figure(
  image("assets/app/c-q3-by-wb-exp.png"),
  caption: "Distribution of answers to C-Q3 by indicated whiteboard tool experience"
)

#figure(
  image("assets/app/c-q4-by-wb-exp.png"),
  caption: "Distribution of answers to C-Q4 by indicated whiteboard tool experience"
)

== Written Feedback <app-written-feedback>

=== After Part 1

After first part of user study: "Was there anything about the modeling interface that you found confusing or frustrating?"
filtered here for comments relevant to work in this thesis (mainly locks & keys)

#block(
  //fill: rgb("e4e5ea"),
  stroke: 1pt + gray,
  inset: (left: 5pt, rest: 15pt),
  radius: 4pt,
  width: 100%,
  breakable: true, [
    #include "assets/app/user-study-feedback-1.typ"
  ]
)

=== After Part 2

After entire user study: "Anything else you want to tell us?"

#block(
  //fill: rgb("e4e5ea"),
  stroke: 1pt + gray,
  inset: (left: 5pt, rest: 15pt),
  radius: 4pt,
  width: 100%,
  breakable: true, [
    #include "assets/app/user-study-feedback-2.typ"
  ]
)

#load-bib()