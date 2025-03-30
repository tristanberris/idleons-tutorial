class_name SecondScene
extends Control

## idleon cost to unlock feature
const COST:int = 25


func _ready() -> void:
	#display locked or unlocked view
	if Game.ref.data.progression.second_scene_unlocked:
		_display_view(true)
	else:
		_display_view(false)
		(%UnlockButton as Button).pressed.connect(_on_unlock_button_pressed)
	
## displays the locked or unlocked tab based on the argument
func _display_view(unlocked:bool = false) -> void:
	#false = 0, true = 1
	($TabContainer as TabContainer).current_tab = int(unlocked)

## Try to unlock feature
func _try_to_unlock() -> void:
	if Game.ref.data.progression.second_scene_unlocked:return		
	var error:Error = IdleonsManager.ref.consume_idleons(COST)
	if error:return
	Game.ref.data.progression.second_scene_unlocked = true
	IdleonGenerator.ref.start_generator()
	_display_view(true) ##connects to above function
	
	
## Reaction to unlock button being pressed
func _on_unlock_button_pressed() -> void:
	_try_to_unlock()
