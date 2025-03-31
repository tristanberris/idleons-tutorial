class_name NutrientsGenerator
extends GeneratorResource
## Passively generates resource

### Singleton reference
#static var ref: BugsEatenGenerator

func _init() -> void:
	generator_name = "Bugs Eaten Generator"
	production_rate = 2.0  # Example base rate
	#var myBugsEatenGenerator = BugsEatenGenerator.new()
	#BugsEatenGenerator.ref = myBugsEatenGenerator
	#var newGen = BugsEatenGenerator.new()
	#GeneratorManager.ref.register_generator(newGen)

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
	BugsManager.ref.consume_bugs(_production) #TODO
	
## Unpauses the generator
func start_generator() -> void:
	if Game.ref.data.progression.bug_collector_unlocked == false:
		return
	var new_gen = NutrientsGenerator.new()  # Create a new instance
	GeneratorManager.ref.register_generator(new_gen)
	
	
	
	_paused = false
	
		
## Triggered when the clock just ticked.
func _on_clock_ticked()->void:
	_progress_cycle()
