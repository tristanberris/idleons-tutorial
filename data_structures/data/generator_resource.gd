extends Resource
class_name GeneratorResource

@export var generator_name: String = "Basic Generator"
@export var production_rate: float = 1.0  # Base units per second
@export var resource_type: String = "nutrients"
@export var upgrade_level: int = 0
@export var cost: Dictionary = {"nutrients": 10}
