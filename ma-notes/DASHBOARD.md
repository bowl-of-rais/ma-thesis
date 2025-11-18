---
milestone: 2512
---

>[!purple] next meeting
> ```tasks
> filter by function task.status.name === 'Meeting'
> limit to 1 tasks
> hide task count
> short mode
> ```

>[!gray] steps in current milestone
>
> ```tasks
> filename does not include glossary
 > status.name includes Milestone
> short mode
> filter by function task.file.property('milestone') === query.file.property('milestone')
> show tree
> hide task count
 > ```

>[!gray] tasks in current milestone
>
> ```tasks
> filename does not include glossary
 > filter by function task.file.property('tags').includes('#task')
> short mode
> filter by function task.file.property('milestone') === query.file.property('milestone')
> group by root
> group by filename
> show tree
> hide task count
 > ```
