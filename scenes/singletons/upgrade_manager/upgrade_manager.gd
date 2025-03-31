class_name UpgradeManager
extends Node
## Manages Crystal Dust Resource

## Singleton Reference
static var ref:UpgradeManager

## Constructor
func _init()->void:
	if not ref:ref=self
	else:queue_free()


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

		if resources.bugs_eaten >= cost:  ## Check if player has enough bugs
			resources.bugs_eaten -= cost  ## Deduct bugs
			upgrades[upgrade_id]["level"] += 1  ## Increase level
			return true  ## Successful purchase
		
	print("false")
	return false  ## Not enough bugs or invalid upgrade
	


### Increases the cost of an upgrade when bought
func calculate_upgrade_cost(base_cost: int, level: int) -> int:
	return int(base_cost * pow(1.5, level))  # Exponential growth
	
