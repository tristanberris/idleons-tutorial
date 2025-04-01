extends Node
class_name ResourceManager

## Singleton Reference
static var ref:ResourceManager

### The amout of idleons has been updated
#signal resource_manager

## Signal to notify when resources are updated
signal resource_updated(resource_type: String, new_amount: float)

## Dictionary to store resource amounts
var resources: Dictionary = {}


## Constructor
func _init() -> void:
	if not ref:ref=self
	else:queue_free()


func add_resource(resource_type: String, amount: float) -> void:
	# Update the local dictionary if needed:
	if resource_type in resources:
		resources[resource_type] += amount
	else:
		resources[resource_type] = amount
		
	# Update the global data directly for "bugs_eaten"
	if resource_type == "nutrients":
		Game.ref.data.resources.nutrients = resources[resource_type]
		

	emit_signal("resource_updated", resource_type, resources[resource_type])
	print(resource_type, " now has ", resources[resource_type], " units.")

func remove_resource(resource_type: String, amount: float) -> void:
	if resource_type in resources:
		resources[resource_type] -= amount
	else:
		resources[resource_type] = amount
		
	# Update the global data directly for "bugs_eaten"
	if resource_type == "nutrients":
		Game.ref.data.resources.nutrients = resources[resource_type]
	

func get_resource_amounts(resource_type:String)->float:
	if resource_type == "nutrients":
		return Game.ref.data.resources.nutrients
	return resources.get(resource_type, 0)
