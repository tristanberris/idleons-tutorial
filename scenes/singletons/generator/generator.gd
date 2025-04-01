extends Node
class_name Generator

# Base production rate (units per second)
var production_rate: float = 1.0 #setget set_production_rate

# Type of resource this generator produces
var resource_type: String = ""

# Active flag to control production
var active: bool = false

# Timer to handle production intervals
var production_timer: Timer

func _ready():
	production_timer = Timer.new()
	add_child(production_timer) ##What does this do?
	_update_timer_wait_time()
	production_timer.timeout.connect(_on_production_timer_timeout)
	production_timer.start()

func set_production_rate(new_rate: float) -> void:
	production_rate = new_rate
	_update_timer_wait_time()

func _update_timer_wait_time() -> void:
	if production_rate > 0:
		production_timer.wait_time = 1.0 / production_rate

func _on_production_timer_timeout():
	if active:
		produce_resource()

# Virtual function to be overridden by subclasses
func produce_resource():
	push_warning("produce_resource() not implemented - please override in subclass")
