---
milestone: 2512
next-weekly: 2025-12-08
prev-weekly: 2025-12-01
tags:
  - meta
---

>[!purple] next meeting
> ```tasks
> filter by function task.status.name === 'Meeting'
> limit to 1 tasks
> hide task count
> short mode
> hide edit button
> ```

>[!gray] tasks from last week
>
> ```tasks
> filename does not include glossary
> short mode
> filter by function task.file.property('milestone') === query.file.property('milestone')
> due on {{query.file.property('prev-weekly')}}
> group by root
> show tree
> hide task count
> hide edit button
 > ```

>[!gray] tasks for this week
>
> ```tasks
> filename does not include glossary
> short mode
> filter by function task.file.property('milestone') === query.file.property('milestone')
> due on {{query.file.property('next-weekly')}}
> group by root
> show tree
> hide task count
> hide edit button
 > ```

>[!gray] context: current milestone
>
> ```tasks
> filename does not include glossary
 > status.name includes Milestone
> short mode
> filter by function task.file.property('milestone') === query.file.property('milestone')
> show tree
> hide task count
> hide postpone button
> hide edit button
> group by root
 > ```
