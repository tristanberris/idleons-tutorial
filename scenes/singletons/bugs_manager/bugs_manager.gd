class_name BugsManager
extends Node
## Manages the idleon resource

## Singleton Reference
static var ref:BugsManager

## Constructor
func _init() -> void:
	if not ref:ref=self
	else:queue_free()

## The amout of idleons has been updated
#signal idleons_updated
signal bugs_updated

### Reference to access game data
var data:Data = Game.ref.data
func get_bugs_eaten()->int:
	return data.resources.bugs_eaten #TODO

	
func consume_bug()->void:
	
	data.resources.bugs_eaten += 1
	bugs_updated.emit()
	#return OK
	

### Tries to consume bugs
func consume_bugs(quantity:int)-> Error:
	if quantity < 0:return FAILED

	#if quantity > data.resources.bugs:return FAILED ##not enough idleons, too expensive
	
	data.resources.bugs_eaten += quantity
	bugs_updated.emit()

	return OK
