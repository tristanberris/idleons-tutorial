class_name Clock
extends Node
## a ticking clock used to manage time in-game

## Singleton Reference
static var ref : Clock

## Constructor
func _init() -> void:
	if not ref:ref = self
	else:queue_free() 
	
## Emitted when the clock just ticked
signal ticked

## Time necessary for a tick to occur
var _tick_duration:float = 1.0
## Progress towards next tick
var _tick_progression:float = 0.0


func _process(delta: float) -> void:
	_tick_progression += delta
	
	if _tick_progression >= _tick_duration:
		_tick()
		
		
		
func _tick()->void:
	_tick_progression -= _tick_duration
	ticked.emit()
		
