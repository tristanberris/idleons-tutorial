class_name FourthScene
extends Control
## Primary divergent scene for new project



#var _slot_component : PackedScene=preload("res://scenes/components/inventory_slot.tscn")
### List of crystals created
#var _crystals:Array[CrystalResource] = [] #empty array
## Label displaying the crystal list.
#@onready var _label : Label = %Label
#@onready var _inventory_container : VBoxContainer = %InventoryContainer

##Ready function
### This %Button as Button uses the unique name of Button function
func _ready()-> void:
	#CrystalInventory.ref.inventory_updated.connect(_on_inventory_updated)
	(%EatBugButton as Button).pressed.connect(_on_button_pressed)
	#update_label()
	#_update_inventory_slots()

## Create a crystal and add it to the list
func _eat_bug(quantity:int)->void:
	BugsManager.ref.consume_bugs(quantity)
	#_instantiate_inventory_slot(_crystals.size()-1)
	#update_label()
	
## Watches the button being pressed.
func _on_button_pressed()-> void:
	_eat_bug(1)
	
#func update_label() -> void:
	#(get_node("Label") as Label).text = "Bugs eaten: %s"%BugsManager.ref.get_bugs_eaten()
	
