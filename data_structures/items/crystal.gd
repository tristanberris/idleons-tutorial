class_name CrystalResource
extends Resource
## Modal of a Crystal Resource

##Idealon value
var _value : int 

## Constructor
### Method that is called when a class is being created in an object.
### When the item is created, the value will be set within the constructor
func _init() -> void:
	_value = randi_range(5, 25)
	
	
