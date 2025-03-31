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
		# Only instantiate the generator if the collector is unlocked
		var nutrients_gen = NutrientsGenerator.new()
		nutrients_gen.generator_name = "NutrientsGenerator"
		GeneratorManager.ref.register_generator(nutrients_gen)
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
	
	ResourceManager.ref.add_resource("nutrients", quantity)
	#_instantiate_inventory_slot(_crystals.size()-1)
	#update_label()
	
## Watches the button being pressed.
func _on_button_pressed()-> void:
	_eat_bug(1)
	
#func update_label() -> void:
	#(get_node("Label") as Label).text = "Bugs eaten: %s"%BugsManager.ref.get_bugs_eaten()
## Try to unlock feature
func _try_to_unlock(upgrade:String) -> void:
	##goal: pass string into upgrade manager, return whether upgrade was successful
	####if successful, do something
	var upgrade_success = UpgradeManager.ref._increase_upgrade_level(upgrade)
	if upgrade_success:
		Game.ref.data.progression.bug_collector_unlocked = true
		
		# Use the manager to get the correct generator instance
		var gen = GeneratorManager.ref.get_generator_by_name("NutrientsGenerator")
		if gen == null:
			gen = NutrientsGenerator.new()
			gen.generator_name = "NutrientsGenerator"
			GeneratorManager.ref.register_generator(gen)
		gen.start_generator()

	
		##pass #TODO

## Reaction to unlock button being pressed
func _on_unlock_button_pressed(upgrade:String) -> void:
	_try_to_unlock(upgrade)
