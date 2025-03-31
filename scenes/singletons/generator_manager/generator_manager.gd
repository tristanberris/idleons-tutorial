class_name GeneratorManager
extends Node

var generators: Array[GeneratorResource] = []
#@onready var generator_manager = get_node("/root/GeneratorManager")

## Singleton Reference
static var ref:GeneratorManager
## Constructor
func _init()->void:
	if not ref:ref=self
	else:queue_free()
	
signal generators_updated
#func _ready():
	##$Timer.start()
	#pass

## Process generator production every tick
func _on_timer_timeout():
	for generator in generators:
		if ResourceManager.ref:
			ResourceManager.ref.add_resource(generator.resource_type, generator.production_rate)

## Register new generators
func register_generator(generator: GeneratorResource):
	generators.append(generator)

## This is how I set up a generator:
#var bugs_eaten_generator = preload("BugsEatenGenerator")
#GeneratorManager.register_generator(bugs_eaten_generator)
