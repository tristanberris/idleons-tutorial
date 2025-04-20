extends Node
class_name BuildingsManager

## Singleton Reference
static var ref:BuildingsManager

var all_buildings: Dictionary = {
	"researchLab": {
		"name": "Research Lab",
		"cost": 5,
		"description": "A lab to research",
		"generator_id": "researchLab",
		"unlocked": false
},
	"observatory": {
		"name": "Observatory",
		"cost": 10,
		"description": "A way to view the stars",
		"generator_id": "observatory",
		"unlocked": false
	}
} 
var unlocked_buildings: Array = []
## Dictionary to store resource amounts
#var buildings: Dictionary = {}

func _ready() -> void:
	ref = self


#func _load_building_definitions() -> void:
	#all_buildings = {
		#"research_lab": Building.new("research_lab","Research Lab",200),
		#"observatory":  Building.new("observatory","Observatory",500)
	#}
	# then fill in description, icon_path, unlocks, etc.…

# Base generator stats – these values never change during gameplay.
#var base_generators: Dictionary = {
	#"bugUpgradeOne": {
		#"name": "Bug Catcher",
		#"cost": 5,
		#"effect": "Catches bugs at a linear rate",
		#"generator_id": "bugUpgradeOne",
		#"production_rate": 1,
		#"amount_owned": 0
	#},
	#"bugUpgradeTwo": {
		#"name": "Second Bug Catcher",
		#"cost": 25,
		#"effect": "Catches bugs at a linear rate",
		#"generator_id": "bugUpgradeTwo",
		#"production_rate": 5,
		#"amount_owned": 0
	#}
#}

func can_unlock_building(id: String) -> bool:
	if not all_buildings.has(id):
		return false
	var chosen_building = all_buildings[id]
	if chosen_building.unlocked:
		return false
	# level requirement
	#if player_level < b.unlock_level:
		#return false
	# building prerequisites
	#for req_id in chosen_building.prerequisite_ids:
		#if not all_buildings[req_id].unlocked:
			#return false
	# cost requirement
	if ResourceManager.ref.get_resource_amounts("nutrients") < chosen_building.cost:
		return false
	return true
	#if not ResourceManager.ref.can_spend(chosen_building.cost):
		#return false
	#return true

# Perform the unlock
func unlock_building(id: String) -> bool:
	if not can_unlock_building(id):
		return false
	var chosen_building = all_buildings[id]
	ResourceManager.ref.spend(chosen_building.cost)
	chosen_building.unlocked = true
	unlocked_buildings.append(chosen_building)
	emit_signal("building_unlocked", chosen_building)
	return true
	
	

func _matches_id(def: Building, id: String) -> bool:
	return def.name == id
