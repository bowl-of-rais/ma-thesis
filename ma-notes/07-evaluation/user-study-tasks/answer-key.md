## Answer Key

### Solvability

#### Variant A: LA_3

**missing keys:**
- not enough bombs for 23-22
- missing key for 20-19

**no outgoing edge:**
- no way out of 6

**unreachable due to edge directionality:**
- area 15/16/26/27/28 unreachable

**softlocks**:
- softlock 9/7/4
- softlock 14/24

**correct observation, but not actual issues:**
- 2 not reachable without ability

*NOTE: softlock 9/7/4 is already present in original game*

#### Variant B: LA_4

**missing keys:**
- missing key for 6 - 12
- missing key for 26-27

**no outgoing edge:**
- no way out of 11

**unreachable due to edge directionality:**
- area 14/21/28 unreachable

**softlocks**:
- softlock 36/37/16
- softlock 7

**correct observation, but not actual issues:**
- 31/39 not unlockable?

### Pacing

#### Variant A: LA_1

path: 
- section A: START 3 6 5 9-3 9-4 17 18 4
- section B: 4 18 17 9-4 9-3 9-1 9-2 13 12
- section C: 12 13 9-2 9-1 9 1- 11 15 BOSS
 
1. no
2. yes, A takes longer on average
3. yes, C has more: 9 in C vs 8 in B
4. 11
5. 9-1 to 9 if both need to have enemies (diff 2), 3 to 6 otherwise (diff 3), 9-3 to 5 if going the long way
6. 15 after 11, 4: A after 18

#### Variant B: LA_2

path: 
- section A: START 1 4 5 7 8 11 10 12 13 14 15 16 18 19 20
- section B: 20 19 21-1 21-2 21-3 23
	- alternative: 20 19 18 16 17 23
- section C: 23 21-3 22 25 BOSS

1. yes (kinda)
2. yes, rooms in section A take longer on average
3. yes, more enemies in C than B
4. 15
5. 16 (0) to 18 (3), 23 (3) to 21-3 (5)
6. 16 after 18, 
