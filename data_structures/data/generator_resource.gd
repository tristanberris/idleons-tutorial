extends Resource
class_name GeneratorResource

@export var generator_name: String = "Basic Generator"
@export var production_rate: float = 1.0  # Units per second
@export var resource_type: String = "bugs"
@export var upgrade_level: int = 0
@export var active: bool = true

# A method to compute production (could be more complex)
#func produce() -> float:
	##return active ? production_rate : 0.0
	#pass
func produce() -> float:
	if active:
		return production_rate
	return 0.0
