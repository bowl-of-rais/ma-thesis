---
milestone:
---

>[!purple] next meeting
> ```tasks
> filter by function task.status.name === 'Meeting'
> limit to 1 tasks
> hide task count
> short mode
> hide edit button
> ```

>[!gray] steps in current milestone
>
> ```tasks
> filename does not include glossary
 > status.name includes Milestone
> short mode
> tags include {{query.file.property('milestone')}}
> show tree
> hide task count
> hide postpone button
> hide edit button
> group by root
 > ```

>[!gray] tasks in current milestone
>
> ```tasks
> filename does not include glossary
 > filter by function task.file.property('tags').includes('#task')
 > filter by function !'?tri'.includes(task.status.symbol)
> short mode
> filter by function task.file.property('milestone') === query.file.property('milestone')
> group by root
> group by filename
> show tree
> hide task count
> hide edit button
> exclude sub-items
 > ```

>[!gray] tasks outside of milestones
>
> ```tasks
> not done
> group by root
> group by filename
> filename does not include milestones
> filename does not include glossary
> filter by function ! task.file.hasProperty('milestone')
> root does not include meetings
> short mode
> exclude sub-items
> show tree
 > ```