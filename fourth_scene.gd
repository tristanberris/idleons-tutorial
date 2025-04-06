class_name FourthScene
extends Control
## Primary divergent scene for new project

## bugs eaten cost to unlock feature
const COST:int = 5
var is_eat_bug_button_held: bool = false
var accumulate_rate: float = 10.0  # resources per second
var nutrients_hold_timer: float = 0.0
var well_hold_timer: float = 0.0
##Ready function
### This %Button as Button uses the unique name of Button function
func _ready()-> void:
	#CrystalInventory.ref.inventory_updated.connect(_on_inventory_updated)
	(%EatBugButton as Button).pressed.connect(_on_button_pressed)
	(%CollectWaterButton as Button).pressed.connect(_on_water_button_pressed)
	(%EatBugButton as Button).connect("gui_input", Callable(self, "_on_eat_bug_button_gui_input"))
	#update_label()
	#_update_inventory_slots()
	if Game.ref.data.progression.bug_collector_unlocked:
		# Only instantiate the generator if the collector is unlocked
		var nutrients_gen = NutrientsGenerator.new()
		nutrients_gen.generator_name = "NutrientsGenerator"
		GeneratorManager.ref.register_generator(nutrients_gen)
	else:
		_display_view(false)

## displays the locked or unlocked tab based on the argument
func _display_view(unlocked:bool = false) -> void:
	pass

## Create a crystal and add it to the list
func _add_nutrients(quantity:int)->void:
	ResourceManager.ref.add_resource("nutrients", quantity)
	
## Watches the button being pressed.
func _on_button_pressed()-> void:
	_add_nutrients(1)
	
func _on_eat_bug_button_gui_input(event: InputEvent) -> void:
	# This handles when the left mouse button is pressed/released over the button
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		is_eat_bug_button_held = event.pressed
		
func _process(delta: float) -> void:
	# If the button is being held, add resources gradually
	if is_eat_bug_button_held:
		nutrients_hold_timer += delta
		if nutrients_hold_timer >= 0.33:
			_add_nutrients(1)
			nutrients_hold_timer -= 0.33  # subtract 1 second; preserves any extra time
	else:
		nutrients_hold_timer = 0.0  # Reset timer if button isn't held

	
func _on_water_button_pressed()-> void:
	
	(%WaterProgressBar as ProgressBar).value += 20
	if (%WaterProgressBar as ProgressBar).value == 100:
		_add_water(1)
		(%WaterProgressBar as ProgressBar).value = 0
		

	
func _add_water(quantity:int)->void:
	ResourceManager.ref.add_resource("water", quantity)
	
## Try to unlock feature
func _try_to_unlock(upgrade:String) -> void:
	##goal: pass string into upgrade manager, return whether upgrade was successful
	####if successful, do something
	GeneratorManager.ref.purchase_nutrients_generator()
	var upgrade_success = UpgradeManager.ref._increase_upgrade_level(upgrade)
	if upgrade_success:
		Game.ref.data.progression.bug_collector_unlocked = true
		_add_nutrients(0) #This basically functions as a way to update my label
		# Use the manager to get the correct generator instance
		var gen = GeneratorManager.ref.get_generator_by_name("NutrientsGenerator")
		if gen == null:
			gen = NutrientsGenerator.new()
			gen.generator_name = "NutrientsGenerator"
			GeneratorManager.ref.register_generator(gen)
		gen.start_generator()

## Reaction to unlock button being pressed
func _on_unlock_button_pressed(upgrade:String) -> void:
	_try_to_unlock(upgrade)
