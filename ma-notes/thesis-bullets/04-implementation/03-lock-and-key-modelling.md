based on
- [[02-lock-key-modeling]]

## Modeling Locks and Keys

### General Idea/Goal

- represent locks/keys internally and in statechart
	- locks assigned to edges
	- keys assigned to nodes

### Underlying Data Model

- based on taxonomy by [@dormansCyclicGeneration2017]

1. locks may be unlocked permanently, temporarily, or until they are relocked, or they collapse after passing
	- explicit attribute of locks: `unlockedUntil`
2. locks may be valves (only open in one direction) or asymmetrical (traversable in both directions)
	- valves are implicitly modeled in statechart: edges are uni-directional
	- asymmetrical TODO
3. locks may or may not have a guaranteed solution (safe vs unsafe)
	- TODO
4. keys may be single- or multi-purpose
	- explicit attribute of keys: `type`, can be `ability` or `item`
	- for now, keys are the only items modeled in statechart -> potential future work
5. keys may be particular or non-particular
	- implicitly modeled by assignment of permissible keys to locks
6. keys may be consumable or persistent
	- explicit attribute of keys:  `consumable`

- data model/structures otherwise analogous to `PxComponents`
- aligns with design philosophy: make highly configurable for users
- complete data model of locks and keys:

![[02-lock-key-modeling#^lockkeydatamodel]]

### Creation and Assignment of Locks and Keys

- again, very analogous to `PxComponents`
- one page where definitions can be created for both locks and keys
- keys are assigned to nodes, same as `PxComponents`
- locks are assigned to edges, which only exist in the context of the chart, so they must be assigned there as well
- TODO

### Visual Representation of Locks and Keys

- principle based on [@brownHowMyBoss2026]: high-level charts that focus on lock/key relations

- [ ] add more details about visualizing locks/keys?

- TODO example screenshots
