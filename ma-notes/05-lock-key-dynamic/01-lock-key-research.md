---
start: 2026-02-23
end:
task-status: in progress
task-category: research
tags:
  - "#research"
milestone: 26-03
---

- [x] research definition of lock/key puzzles ✅ 2026-03-02
- [/] research extendability: comparable types of puzzles? to not make the feature too niche?
- [/] look into hard vs softly required keys, especially softly
- [ ] do readings -> [[05-lock-key-dynamic/readings|readings]]
- [/] write about locks/keys in general -> [[lock-and-key]]

## Definition

[@ashmoreQuestGeneratedWorld2007]:
>The puzzle is finding out what is an obstacle, what and where is a key to overcome it, and finally using the key to master the challenge.

- in statechart: conditional transition

[@ashmoreQuestGeneratedWorld2007]:
>Obstacles may not be passed until the player obtains some token (such as an item or skill)

-> keys as abstract tokens, different kinds to distinguish: keys/locks should have some category to specify this

[@dormansGameMechanicsAdvanced]:
>If we want to involve player skill, rather than simply the presence or absence of a player ability, we need a different mechanism.

- #future_work : according to [@dormansGameMechanicsAdvanced], there are also dynamic keys

## Soft Keys

[@dormansCyclicGeneration2017]:
>Some locks are barriers that might be navigated without a key, but this crossing the barrier might be uncertain or impose a certain risk.

[@dormansGameMechanicsAdvanced2012]:
>combines a skill-based lock with a more traditional lock-and-key mechanism (p.254)

- [I] add additional lock type: `skill`
	- `skill`-only locks raise difficulty of subsequent levels (highlight in a different color)?
	- add to difficulty component on nodes
		- (potentially: add "difficulty" as an optional pre-defined component definition)

## Context

- [@ashmoreQuestGeneratedWorld2007] present lock/key puzzles as a type of quest
- #future_work: model/analyze other types of quests (explicit, specific tasks, mission objectives)
