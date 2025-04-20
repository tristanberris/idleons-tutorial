extends Node
class_name BuildingsManager

## Singleton Reference
static var ref:BuildingsManager

@onready var game_tabs: TabContainer = get_node("../FourthScene/MarginContainer/HBoxContainer/RightPanel/MarginContainer/GameTabs")


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

func _ready() -> void:
	ref = self

func can_unlock_building(id: String) -> bool:
	if not all_buildings.has(id):
		return false
	var chosen_building = all_buildings[id]
	if chosen_building.unlocked:
		return false
	# building prerequisites
	#for req_id in chosen_building.prerequisite_ids:
		#if not all_buildings[req_id].unlocked:
			#return false
	# cost requirement
	if ResourceManager.ref.get_resource_amounts("nutrients") < chosen_building.cost:
		return false
	return true

# Perform the unlock
func unlock_building(id: String) -> bool:
	if not can_unlock_building(id):
		return false
	var chosen_building = all_buildings[id]
	ResourceManager.ref.remove_resource("nutrients",chosen_building.cost)
	chosen_building.unlocked = true
	unlocked_buildings.append(chosen_building)
	_create_new_building_tab(id)
	emit_signal("building_unlocked", chosen_building)
	return true
	
func _get_building_name(id:String) -> String:
	var building_name = all_buildings[id].name
	return building_name
	
func _create_new_building_tab(id: String) -> void:
	# safety checks
	#if not all_buildings.has(id):
		#push_error("Tried to create tab for unknown building: " + id)
		#return

	# 1. Grab your TabContainer (tweak the path to fit your scene tree)
	#var tab_container = %GameTabs

	# 2. Create the page node (you can swap PanelContainer for whatever root you like)
	var page = PanelContainer.new()
	page.name = str(all_buildings[id])
	#tab_container.add_child(page)
	game_tabs.add_child(page)
	#%GameTabs.add_child(page)

	# 3. Title the new tab with the building's human‑readable name
	var title = all_buildings[id]["name"]
	var new_index = game_tabs.get_tab_count() - 1
	game_tabs.set_tab_title(new_index, title)

	# 4 (optional). If you have a dedicated scene for the contents of each tab:
	# var scene = preload("res://scenes/BuildingTabContent.tscn").instance()
	# page.add_child(scene)
#func _matches_id(def: Building, id: String) -> bool:
	#return def.name == id
