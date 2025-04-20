class_name Building
extends Resource

var id: String
var name: String
var description: String
var base_cost: float

var prerequisite_ids: Array = []   # e.g. ["Barn","Windmill"]
var level: int = 1
var max_level: int = 10  # or –1 for “infinite” upgrades

var unlocked: bool = false

func _init(_name: String, _cost: float) -> void:
	name = _name
	base_cost = _cost
