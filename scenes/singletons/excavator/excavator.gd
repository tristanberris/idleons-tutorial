class_name Excavator
extends Node
## Singletons managing the excavator


## Singleton reference.
static var ref:Excavator

## Constructor
func _init()->void:
	if not ref:ref=self
	else:queue_free()
	
	
## Public entry point triggering an excavating action.
## This is set to match what was in the first scene soo far in the series. 
func excavate()->void:
	IdleonsManager.ref.create_idleons(5)
	var roll:int = randi_range(0,99)
	
	if roll<33:
		var crystal:CrystalResource = CrystalResource.new()
		CrystalInventory.ref.add_crystal(crystal)
