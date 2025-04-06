extends Node
class_name GeneratorManager

# Singleton reference
static var ref: GeneratorManager

# Base generator stats – these values never change during gameplay.
var base_generators: Dictionary = {
	"bugUpgradeOne": {
		"name": "Bug Catcher",
		"cost": 5,
		"effect": "Catches bugs at a linear rate",
		"generator_id": "bugUpgradeOne",
		"production_rate": 1,
		"amount_owned": 0
	},
	"bugUpgradeTwo": {
		"name": "Second Bug Catcher",
		"cost": 25,
		"effect": "Catches bugs at a linear rate",
		"generator_id": "bugUpgradeTwo",
		"production_rate": 5,
		"amount_owned": 0
	}
}

# Runtime state for each generator – these values change during gameplay.
var runtime_generators: Dictionary = {}
# Array to store generator resources
#var generators: Array = []

# Constructor: ensure only one instance exists
func _init() -> void:
	if not ref:
		ref = self
	else:
		queue_free()
		
# Reference to the ResourceManager (which manages global resources)
# Assume ResourceManager is set up as a singleton using your preferred pattern
# e.g., ResourceManager.ref.add_resource(...)

func _ready():
	_initialize_runtime_generators()
	# Create a timer to process generator production every second.
	var timer = Timer.new()
	timer.wait_time = 0.5
	timer.one_shot = false
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

# Create a mutable copy of the base generator stats.
func _initialize_runtime_generators() -> void:
	for id in base_generators.keys():
		runtime_generators[id] = {
			"level": 0,
			"cost": base_generators[id]["cost"],
			"active": false,
			"amount_owned": 0,
			"production_rate": base_generators[id]["production_rate"]
		}

# Retrieves the runtime data for a given generator.
func get_generator_runtime_data(generator_id: String):
	if runtime_generators.has(generator_id): ##Issue is likely the .has
		return runtime_generators[generator_id]
	print("No runtime data found for generator:", generator_id)
	return null

# Check if the generator can be purchased.
func can_purchase_generator(generator_id: String) -> bool:
	var runtime_data_variant = get_generator_runtime_data(generator_id)
	if runtime_data_variant == null:
		return false
	var runtime_data: Dictionary = runtime_data_variant as Dictionary
	# Assume the resource is "bugs" – adjust as needed.
	if ResourceManager.ref.get_resource_amounts("nutrients") >= runtime_data["cost"]:
		return true
	return false

# Process the purchase and delegate any upgrade logic.
func purchase_generator(generator_id: String) -> bool:
	if not can_purchase_generator(generator_id):
		print("Insufficient resources to purchase generator: ", generator_id)
		return false

	var runtime_data_variant = get_generator_runtime_data(generator_id)
	if runtime_data_variant == null:
		print("Runtime data for generator ", generator_id, " not found!")
		return false

	# Cast the returned variant to a Dictionary.
	var runtime_data: Dictionary = runtime_data_variant as Dictionary

	# Now you can safely use it.
	ResourceManager.ref.remove_resource("nutrients", runtime_data["cost"])
	#if runtime_data["level"] == 0:
	runtime_data["level"] += 1
		
	runtime_data["amount_owned"] += 1
	runtime_data["active"] = true  # Mark as active.
	print("Purchased generator: ", base_generators[generator_id]["name"], " new level: ", runtime_data["level"])
	if runtime_data["level"] > 0:
		UpgradeManager.ref.apply_upgrade(generator_id, runtime_data)#TODO
	return true
	
func _on_timer_timeout() -> void:
	for generator_id in runtime_generators.keys():
		var data = runtime_generators[generator_id] as Dictionary
		if data.has("active") and data["active"]:
			var produced_amount = _calculate_production(generator_id, data)
			ResourceManager.ref.add_resource("nutrients", produced_amount)
			#print("Generator", generator_id, "produced", produced_amount, "bugs.")
	

func _calculate_production(generator_id: String, data: Dictionary) -> float:
	var base_rate = base_generators[generator_id].get("production_rate", 1.0)
	return base_rate * data["level"]
