class_name CrystalResource
extends Resource
## Modal of a Crystal Resource

##Idealon value
var _value : int 

var _name:String

## Constructor
### Method that is called when a class is being created in an object.
### When the item is created, the value will be set within the constructor
#func _init() -> void:
	#_value = randi_range(5, 25)
	
static func create_common_crystal()->CrystalResource:
	var new_crystal:CrystalResource = CrystalResource.new()
	
	new_crystal._name = "Common Crystal"
	new_crystal._value = randi_range(5,10)
	
	
	return new_crystal
	
static func create_rare_crystal()->CrystalResource:
	var new_crystal:CrystalResource = CrystalResource.new()
	
	new_crystal._name = "Rare Crystal"
	new_crystal._value = randi_range(100,250)
	
	return new_crystal	
	
