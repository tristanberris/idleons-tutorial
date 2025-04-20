extends Node
class_name NutrientsManager

## Singleton Reference
static var ref:NutrientsManager

## Constructor
func _init()->void:
	if not ref:ref=self
	else:queue_free()


func convert_bugs_into_nutrients()->void:
	_convert_bugs_into_nutrients()
	
const BUGS_PER_NUTRIENT = 3

# Get a reference to the resource manager node.
# Adjust the node path ("/root/ResourceManager") according to your scene tree.
@onready var resource_manager = ResourceManager.ref

# This function converts the player's bugs into nutrients.
func _convert_bugs_into_nutrients():
	
	var current_bugs = resource_manager.get_resource_amounts("bugs")
	# Check if there are enough bugs to perform a conversion.
	if current_bugs < BUGS_PER_NUTRIENT:
		print("Not enough bugs to convert!")
		return
		
	resource_manager.add_resource("nutrients", 1)
	resource_manager.remove_resource("bugs", BUGS_PER_NUTRIENT)
	
	#var nutrients_to_add = int(current_bugs / BUGS_PER_NUTRIENT)
	#resource_manager.add_resource("nutrients", nutrients_to_add)
	#resource_manager.remove_resource("bugs", nutrients_to_add * BUGS_PER_NUTRIENT)
	# Optionally, update any UI elements or trigger other events here.
	#print("Converted ", current_bugs, " bugs into ", nutrients_to_add, " nutrients.")
	print("Converted ", current_bugs, " bugs into ", 1, " nutrients.")
