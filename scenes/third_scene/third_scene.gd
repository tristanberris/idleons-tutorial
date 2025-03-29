class_name ThirdScene
extends Control
## Debug scene to create and visualize crystals



var _slot_component : PackedScene=preload("res://scenes/components/inventory_slot.tscn")
### List of crystals created
#var _crystals:Array[CrystalResource] = [] #empty array
## Label displaying the crystal list.
#@onready var _label : Label = %Label
@onready var _inventory_container : VBoxContainer = %InventoryContainer

##Ready function
### This %Button as Button uses the unique name of Button function
func _ready()-> void:
	CrystalInventory.ref.inventory_updated.connect(_on_inventory_updated)
	(%Button as Button).pressed.connect(_on_button_pressed)
	_update_inventory_slots()

## Create a crystal and add it to the list
func _create_crystal()->void:
	var crystal : CrystalResource = CrystalResource.new() #creates a new instance of CrystalResource model
	CrystalInventory.ref.add_crystal(crystal)
	#_instantiate_inventory_slot(_crystals.size()-1)
	
## Reset the inventory display to update the last known state.
func _update_inventory_slots()->void:
	_clear_inventory_container()
	_instantiate_inventory_slots()

## Instantiate all inventory slots
func _instantiate_inventory_slots()->void:
	var counter:int = 0
	
	for crystal:CrystalResource in CrystalInventory.ref.get_crystals():
		_instantiate_inventory_slot(counter)
		counter += 1
	
	
	
func _instantiate_inventory_slot(index:int)->void:
	## we instantiate a packed scene
	var component:InventorySlot = _slot_component.instantiate()
	## this is the birth of the component, setting default values basically?
	component.set_resource(CrystalInventory.ref.get_crystal(index))
	component.set_index(index)
	component.set_container(self)
	
	
	_inventory_container.add_child(component)
	
	
func sell_crystal(index:int)->void:
	var idleons_to_create:int=CrystalInventory.ref.get_crystal(index)._value
	IdleonsManager.ref.create_idleons(idleons_to_create)
	
	CrystalInventory.ref.remove_crystal_at(index)


## Cleans the inventory container Children nodes.
func _clear_inventory_container()->void:
	var inventory_slots:Array[Node]=_inventory_container.get_children()
	for node:Node in inventory_slots:
		node.queue_free()

## Watches the button being pressed.
func _on_button_pressed()-> void:
	_create_crystal()
	
## Triggered when the inventory is updated
func _on_inventory_updated()->void:
	_update_inventory_slots()
