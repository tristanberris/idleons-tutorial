class_name Generator
extends Node

## Base production rate (e.g., units per second)
var production_rate: float = 1.0

## Type of resource this generator produces
var resource_type: String = ""

## Timer to handle production intervals
var production_timer: Timer

func _ready():
	production_timer = Timer.new()
	add_child(production_timer)
	production_timer.wait_time = 1.0 / production_rate
	production_timer.timeout.connect(_on_production_timer_timeout)
	production_timer.start()
	
## Called when the production timer times out
func _on_production_timer_timeout():
	produce_resource()

## Virtual function to be overridden by subclasses
func produce_resource():
	push_warning("produce_resource() not implemented")
	
	
