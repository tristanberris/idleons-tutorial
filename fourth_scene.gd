class_name FourthScene
extends Control
## Primary divergent scene for new project

## bugs eaten cost to unlock feature
const COST:int = 5

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
	if Game.ref.data.progression.bug_collector_unlocked:
		_display_view(true)
	else:
		_display_view(false)
		(%BugCollectorUnlockButton as Button).pressed.connect(Callable(self, "_on_unlock_button_pressed").bind("bugUpgradeOne"))

## displays the locked or unlocked tab based on the argument
func _display_view(unlocked:bool = false) -> void:
	#false = 0, true = 1
	#($TabContainer as TabContainer).current_tab = int(unlocked)
	pass

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
## Try to unlock feature
func _try_to_unlock(upgrade:String) -> void:
	
	if upgrade == "bugUpgradeOne":
		if Game.ref.data.progression.bug_collector_unlocked:return
		var error:Error = BugsManager.ref.spend_eaten_bugs(COST)
		if error:return
		Game.ref.data.progression.bug_collector_unlocked = true
		BugsEatenGenerator.ref.start_generator()
		_display_view(true) ##connects to above function
		#pass #TODO
		
	#if Game.ref.data.progression.second_scene_unlocked:return		
#
	#var error:Error = IdleonsManager.ref.consume_idleons(COST)
## Reaction to unlock button being pressed
func _on_unlock_button_pressed(upgrade:String) -> void:
	_try_to_unlock(upgrade)
