class_name IdleonsManager
extends Node
## Manages the idleon resource

## Singleton Reference
static var ref:IdleonsManager

## Constructor
func _init() -> void:
	if not ref:ref=self
	else:queue_free()

## The amout of idleons has been updated
signal idleons_updated
# signal idleons_created OR
# signal idleons_consumed

## Reference to access game data
var data:Data = Game.ref.data


func get_idleons()->int:
	return data.resources.idleons
	
# Creates idleons
func create_idleons(quantity:int) -> Error:
	if quantity <= 0:return FAILED
	
	data.resources.idleons += quantity
	idleons_updated.emit()
	return OK
	
	
## Tries to consume idleons
func consume_idleons(quantity:int)-> Error:
	if quantity < 0:return FAILED

	if quantity > data.resources.idleons:return FAILED ##not enough idleons, too expensive
	
	data.resources.idleons -= quantity
	idleons_updated.emit()

	return OK
