#import "../utils.typ": todo
#import "../bib.typ": load-bib

= Future Work <id>

== Implementation

=== Internals

- move calculation into backend

=== UI/UX

- based on user study participant feedback: easier editing of component/key/lock assignments (lock buttons, context menus) #todo("add reference")
- clearer feedback for pathfinding results

=== Extended and Additional Functionalities

- as mentioned in @impl-diagrams: persist/save paths, add other types of diagrams, assign path selections to specific diagrams.
- as mentioned in @impl-lk: integrate further lock/key variants into pathfinding (fixed keys, different unlock modes). move pathfinding to backend.
- from user study: in-diagram calculations (sums/averages), different settings for revisiting nodes (e.g. respawning enemies vs not)

branching out:
- using LLMS:
  - LLM-based pacing analyses
  - LLM-based creation of components/locks/keys from description
  - consistency check based on description
- path-finding, path-based analysis:
  - structural checks
  - maybe something with petri nets? #todo("research petri nets")
- solvability:
  - path-agnostic analysis (single button "analyze" to check for any solvability issues)
- diagrams:
  - #todo("think of something")

=== Other

- evaluation of missing features (creation of definitions, some analysis features e.g. soft gates)
- larger case study where system is used and evaluated more in-depth/over a longer amount of time, potentially via automatically collected data in a productive system


#load-bib()