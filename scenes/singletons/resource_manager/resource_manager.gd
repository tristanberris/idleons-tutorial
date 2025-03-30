extends Node
class_name ResourceManager

## Singleton Reference
static var ref:ResourceManager

### The amout of idleons has been updated
#signal resource_manager

## Signal to notify when resources are updated
signal resource_updated(resource_type: String, amount: float)

## Dictionary to store resource amounts
var resources: Dictionary = {}


## Constructor
func _init() -> void:
	if not ref:ref=self
	else:queue_free()


func add_resource(resource_type: String, amount: float):
	if resource_type in resources:
		resources[resource_type] += amount
	else:
		resources[resource_type]=amount
	emit_signal("resource_updated", resource_type, resources[resource_type])
	print(resource_type, " now has ", resources[resource_type], " units.")


func get_resource_amounts(resource_type:String)->float:
	return resources.get(resource_type, 0)
