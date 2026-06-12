# Testing PxLocks and PxKeys

## PxKey Definitions and PxLock Definitions

### Create

- PxKey/PxLock definitions can be created using the forms on the "Lock and Key Definitions" page
- Newly created definitions appear on the right hand side
	- If there are more definitions than fit on the page, the definitions can be scrolled through horizontally
- If any of the fields marked with an asterisk or the "Name" field are missing, they are highlighted accordingly

### Edit

- PxKey/PxLock definitions can be edited in the cards on the "Lock and Key Definitions" page

## PxKeys

- PxKeys can be added to PxNodes using the "Add Key" button in a detailed view of a node (e.g. on the "Nodes" page)
- PxKeys can be deleted from PxNodes using the trash icon button in the node card

## PxLocks

- When an edge in a chart is selected, the "Add or Edit Locks" button appears in the top right corner
- PxLocks can be added to a selected edge in a chart by clicking the button and modifying the counts in the "Edit Locks on Edge" dialog
	- The dialog lists all PxLock definitions. Hovering over the Key icon shows the keys that the respective lock will be unlocked by.

## Pathfinding

### Settings

- Pathfinding settings can be edited using the "Edit Settings" button in the top right corner of a chart.
- Settings are specific to a chart.
- Default settings: use locks & keys ON, ignore consumable keys OFF, show soft locks OFF

### Basic Lock & Key Path

locks & keys enabled in settings:
![[Pasted image 20260512225647.png]]

locks & keys disabled in settings:
![[Pasted image 20260512225818.png]]

### Fixed Keys Only Unlock Next Lock

![[Pasted image 20260512230246.png]]

### Paths Behind Soft Gates Highlighted Differently

without key:
![[Pasted image 20260512230315.png]]

with key:
![[Pasted image 20260512230421.png]]

### Consumable Keys Only Unlock Next Lock

![[Pasted image 20260512230510.png]]

### Soft Locks Are Avoided

![[Pasted image 20260512230627.png]]

The first lock can be unlocked with both keys, the second lock only with one of the keys.

with "Show Soft Locks" enabled in settings:
![[Pasted image 20260512230805.png]]

## Limitations

- validation in Card components (i.e. when editing Lock/Key Definitions)
	- also relevant for e.g. Node Cards
- editing key count (workaround: delete and add with different count)
- adding/editing locks on edges can currently only be done one edge at a time
