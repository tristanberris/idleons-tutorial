class_name BugsEatenGenerator
extends Node
## Passively generates resource

## Singleton reference
static var ref:BugsEatenGenerator

## Constructor
func _init() -> void:
	if not ref:ref=self
	else: queue_free()


## Duration of a production cycle
var _cycle_duration:float = 0.5
## Progression toward the next production cycle
var _cycle_progression:float = 0.0
## Amount of resources produced each cycle
var _production:int=1
var _paused:bool=true

func _ready() ->void:
	Clock.ref.ticked.connect(_on_clock_ticked)
	
	if Game.ref.data.progression.bug_collector_unlocked:
		_paused = false
	else:
		_paused = true
		
## Progress the production cycle.
func _progress_cycle()->void:
	if _paused:return
	
	_cycle_progression += 0.5
	
	if _cycle_progression >= _cycle_duration:
		_generate()
		
## Generate resources and refresh the cycle progression.
func _generate()->void:
	_cycle_progression -= _cycle_duration
	BugsManager.ref.consume_bugs(_production)
	
## Unpauses the generator
func start_generator() -> void:
	if Game.ref.data.progression.bug_collector_unlocked == false:
		return
	
	_paused = false
	
		
## Triggered when the clock just ticked.
func _on_clock_ticked()->void:
	_progress_cycle()
