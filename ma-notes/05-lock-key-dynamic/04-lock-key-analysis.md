---
start: 2026-04-12
end:
task-status:
task-category: implementation
tags:
  - "#research"
  - "#implementation"
milestone: 26-05
---

- [/] research angles for analysis
- [/] implement analysis
- [ ] write about analysis for locks/keys

## Possible Analysis Angles

- [x] simplest: feasibility evaluation -> can puzzle even be solved? / does a path exist?
- notify when alternative paths (without locks) exist/distinguish between locked and unlocked paths 
- complexity/experience analysis -> is puzzle too difficult to be enjoyable?
	- maybe also independent of paths
- [@dormansCyclicGeneration2017]: gives recommendations on how key/lock types might work well together
	- [?] can we use this?
- [x] [@cooperStuckMiddleGenerating2025], [@mawhorterSoftlockDetectionSuper2021]: soft-lock detection
	- mainly via consumable keys -> see [[#Implementation]]

## Implementation

- [x] check for path existence ✅ 2026-04-12
	- implicit: tries to find shortest unlocked path

- [ ] highlight blocking locks only

- [x] improve key consumption logic: maintain variants of keysets ✅ 2026-04-27
	- this results in soft-lock detection
- [x] highlight possible soft-locks ✅ 2026-05-12

>[!example]
>```mermaid
>graph LR
>	a([A]) --unlocked by X or Y--> b([B])
>	b --unlocked by Y--> c([C])
> ```
> where both X and Y are consumable
> -> if inventory contains one key of type X and one key of type Y, then using Y for the first lock makes C unreachable

