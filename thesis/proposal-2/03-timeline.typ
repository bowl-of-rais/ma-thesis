#import "../utils.typ": todo
#import "@preview/gantty:0.4.0": gantt
#import "../bib.typ": load-bib

= Timeline <prop_timeline>

//#gantt(yaml("assets/timeline-1.yaml"))
//#gantt(yaml("assets/timeline-2.yaml"))

#gantt(yaml("assets/timeline-full.yaml"))

//#set align(horizon)
//#rotate(-90deg, gantt(yaml("assets/timeline-full.yaml")))

\* includes methodology and results


#load-bib()