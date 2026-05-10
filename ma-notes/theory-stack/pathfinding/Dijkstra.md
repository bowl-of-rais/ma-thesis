---
tags:
  - theory
---

# Dijkstra

[Pseudocode (Wikipedia)](https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm#Pseudocode)
```
function Dijkstra(Graph, source, target):
   
    for each vertex v in Graph.Vertices:
        dist[v] ← INFINITY
        prev[v] ← UNDEFINED
        add v to Q
    dist[source] ← 0
   
    while Q is not empty:
        u ← vertex in Q with minimum dist[u]
        if u = target:
	        break
        Q.remove(u)
       
        for each arc (u, v) in Q:
            alt ← dist[u] + Graph.Edges(u, v)
            if alt < dist[v]:
                dist[v] ← alt
                prev[v] ← u
	
	S ← empty sequence
	u ← target
	if prev[u] is defined or u = source: 
		while u is defined: 
			S.push(u)
			u ← prev[u]
	
    return dist[], prev[]
```

[Pseudocode with Priority Queue]
```
function Dijkstra(Graph, source):
    Q ← Queue storing vertex priority
    
    dist[source] ← 0
    Q.add_with_priority(source, 0)
    
    for each vertex _v_ in _Graph.Vertices_:
        if v ≠ source
            prev[v] ← UNDEFINED 
            dist[v] ← INFINITY 
            Q.add_with_priority(v, INFINITY)

    while Q is not empty:  
        u ← Q.extract_min() 
        for each arc (u, v) : 
            alt ← dist[u] + Graph.Edges(u, v)
            if alt < dist[v]:
                prev[v] ← u
                dist[v] ← alt
                Q.decrease_priority(v, alt)

    return (dist, prev)
```
