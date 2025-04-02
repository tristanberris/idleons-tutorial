class_name UpgradeManager
extends Node
## Manages Crystal Dust Resource

## Singleton Reference
static var ref:UpgradeManager

# A dictionary mapping generator IDs to their cost scaling factors.
var upgrade_scaling_factors: Dictionary = {
	"bugUpgradeOne": 1.5,
	"bugUpgradeTwo": 1.8
}

## Constructor
func _init()->void:
	if not ref:ref=self
	else:queue_free()
	
# Applies an upgrade for a given generator.
# This function takes the generator_id and its current runtime_data dictionary,
# and then updates values such as cost (or even production_rate if desired).
func apply_upgrade(generator_id: String, runtime_data: Dictionary) -> void:
	# Look up the scaling factor for this generator.
	if not upgrade_scaling_factors.has(generator_id):
		print("No upgrade rule defined for generator: ", generator_id)
		return
	
	var scaling_factor = upgrade_scaling_factors[generator_id]
	
	# Get the base cost from GeneratorManager's base data.
	# We assume GeneratorManager is a singleton with a public 'base_generators' dictionary.
	var base_data = GeneratorManager.ref.base_generators.get(generator_id, null)
	if base_data == null:
		print("No base data for generator: ", generator_id)
		return
	
	# For example, update the cost so that it scales exponentially with the current level.
	# You can adjust the formula as needed.
	var new_cost = round(base_data["cost"] * pow(scaling_factor, runtime_data["level"]))
	runtime_data["cost"] = new_cost
	
	# Optionally, you could update other values, like production_rate:
	# var base_rate = base_data["production_rate"]
	# runtime_data["production_rate"] = base_rate * runtime_data["level"]
	
	print("Applied upgrade for ", base_data["name"], ". New cost: ", new_cost)


## Emitted when upgrades are updated
signal updated

var resources:DataResources = Game.ref.data.resources

## Reference to access game data
var data:Data = Game.ref.data

## List of all upgrades
var upgrades = {
	"bugUpgradeOne": {
		"name": "Bug Catcher",
		"cost": 5,
		"level": 0,
		"effect": "Catches bugs at a linear rate",
		"upgrade_id": "bugUpgradeOne"
	},
	"bugUpgradeTwo": {
		"name": "Second Bug Catcher",
		"cost": 25,
		"level": 0,
		"effect": "Catches bugs at a linear rate",
		"upgrade_id": "bugUpgradeTwo"
	}
}

## Attempt to purchase an upgrade level
func _increase_upgrade_level(upgrade_id:String)->bool:
	if upgrade_id in upgrades:
		var upgrade = upgrades[upgrade_id] ##This is assigning the dictionary entry to upgrade
		var cost = calculate_upgrade_cost(upgrade["cost"], upgrade["level"])

		if resources.nutrients >= cost:  ## Check if player has enough bugs
			resources.nutrients -= cost  ## Deduct bugs
			upgrades[upgrade_id]["level"] += 1  ## Increase level
			return true  ## Successful purchase
		
	print("false")
	return false  ## Not enough bugs or invalid upgrade
	


### Increases the cost of an upgrade when bought
func calculate_upgrade_cost(base_cost: int, level: int) -> int:
	return int(base_cost * pow(1.5, level))  # Exponential growth
	
