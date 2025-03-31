extends Node
class_name GeneratorManager

# Singleton reference
static var ref: GeneratorManager

# Array to store generator resources
var generators: Array = []

# Constructor: ensure only one instance exists
func _init() -> void:
	if not ref:
		ref = self
	else:
		queue_free()
		
# Reference to the ResourceManager (which manages global resources)
# Assume ResourceManager is set up as a singleton using your preferred pattern
# e.g., ResourceManager.ref.add_resource(...)

#func _ready():
	## Start a timer that ticks every second (or any appropriate interval)
	#var timer = Timer.new()
	#timer.wait_time = 1.0
	#timer.one_shot = false
	#add_child(timer)
	#timer.start()
	#timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	# Process each generator
	for generator in generators:
		var produced_amount = generator.produce()
		# Add production to the global resource.
		# For example, if resource_type is "bugs_eaten":
		ResourceManager.ref.add_resource(generator.resource_type, produced_amount)

# Helper function to get a generator by name (or another unique identifier)
func get_generator_by_name(name: String) -> GeneratorResource:
	for generator in generators:
		if generator.generator_name == name:
			return generator
	return null

func register_generator(generator: GeneratorResource) -> void:
	generators.append(generator)
