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
	var crystal_dust_amount:int = randf_range(2,5)
	
	CrystalDustManager.ref.create(crystal_dust_amount)
	
	## This is essentially a 10% chance. 
	var crystal_creation_roll:int = randf_range(0,99)
	if crystal_creation_roll <= 9:
		_create_a_crystal()

## Create a random amount of crystal dust	
func _create_crystal_dust()->void:
	var crystal_dust_amount:int=randi_range(2,5)
	CrystalDustManager.ref.create(crystal_dust_amount)
	
## Create a random crustal and add it to the inventory
func _create_a_crystal()->void:
	var rare_crystal_roll:int=randi_range(0,99)
	
	var crystal:CrystalResource
	
	if rare_crystal_roll<=9:
		crystal = CrystalResource.create_rare_crystal()
	else:
		crystal = CrystalResource.create_common_crystal()
	
	CrystalInventory.ref.add_crystal(crystal)
