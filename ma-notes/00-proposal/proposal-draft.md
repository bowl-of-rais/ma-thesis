# Something with Usability in PIX:E

- [?] "Usability" in German - auch Usability? oder Gebrauchstauglichkeit?

## Goal

- implement sustainable/maintainable and effective usability/accessibility principles

>[!star] Possible LLM angles
>- usability/general user experience of AI components
>- LLM-supported accessibility
>- LLM-supported Usability Design (agents for usability evaluation, study design etc)

## Approach

### 0. Exploratory Research

- fundamental guidelines and principles of usability
- focus: open source software, planning tools, design toolkits...
### 1. Usability Inspection (Audit)

- examine existing software components
	- maybe focus on some parts of it only
- evaluate current state based on results from 0.
### 2. Initial Improvements

- implement improvements based on inspection and research
### 3. Usability Test (User Study)

- use improved version
	- maybe another round afterwards?
- steps:
	- research how to conduct a user study
	- design user study
	- find participants + conduct study
	- evaluate results

### 4. Further Improvements

- integrate feedback from user study

## Timeline

```mermaid
gantt
    title Thesis Timeline
    dateFormat YYYY-MM-DD
    section " "
		Submission : milestone, 2026-07-15, 1d
    section Research
        Usability Guidelines    :2025-10-15, 2025-11-10
        User Studies            :2026-01-01, 2026-04-01
    section Implementation
        Usability Inspection    :b1, 2025-11-01, 2025-11-30
        Initial Improvements    :b2, 2025-11-21, 2025-12-31
        Further Improvements    :b3, 2026-04-15, 2026-05-15
    section User Study
        Design                  :2026-01-05, 2026-01-31
        Conduct                 :2026-02-01, 2026-03-15
        Evaluate                :2026-03-15, 2026-04-15
    section Writing
	    Introduction            :2026-06-01, 15d
        Background/Related Work :2025-10-25, 6d
        Methodology             :2025-11-15, 2026-05-10
        Usability Inspection    :after b1, 10d
        Initial Improvements    :after b2, 10d
        Usability Test          :2026-01-20, 2026-04-30
        Further Improvements    :after b3, 10d
        Conclusion/Future Work  :2026-06-01, 15d    
```
