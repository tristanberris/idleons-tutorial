class_name CrystalInventory
extends Node
## Singleton managing crystal inventory

## Singleton reference.
static var ref:CrystalInventory

## Constructor
func _init()->void:
	if not ref:ref=self
	else:queue_free()

## Triggered when the inventory is updated
signal inventory_updated

## Data reference.
var data:Data = Game.ref.data

## Returns the inventory as a list
func get_crystals()->Array[CrystalResource]:
	return data.crystals.inventory
	
## Returns a single crystal from the inventory
func get_crystal(index:int)->CrystalResource:
	if index < 0 or index >= data.crystals.inventory.size():return null
	return data.crystals.inventory[index]

## Add a crustal to the inventory.
func add_crystal(crystal:CrystalResource)->Error:
	data.crystals.inventory.append(crystal)
	inventory_updated.emit()
	
	return OK

## Remove a crystal at a specific index.
func remove_crystal_at(index:int)->Error:
	
	if index < 0 or index >= data.crystals.inventory.size():return FAILED
	
	data.crystals.inventory.remove_at(index)
	inventory_updated.emit()
	
	return OK
	
# TODO
## Experimental method to define
func remove_crystal(crystal:CrystalResource)->Error:
	return FAILED
