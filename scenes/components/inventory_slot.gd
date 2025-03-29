class_name InventorySlot
extends MarginContainer
## Inventory slot component



## Resource of the crystal to display
var _resource:CrystalResource

## Index within the list(or array?)
var _index:int

var _container:ThirdScene

## Ready method
func _ready()->void:
	(%SellButton as Button).pressed.connect(_on_sell_button_pressed)

## Public method to be used to set the item in the slot
func set_resource(crystal_resource:CrystalResource)->void:
	_resource = crystal_resource
	_update_properties_label()
	
## Public method to use to set the container reference
func set_container(container:ThirdScene)->void:
	_container=container
	
## Public method used to set the index
func set_index(index:int)->void:
	_index = index


## Update the label node to display the crystal properties
func _update_properties_label()->void:
	(%ItemProperties as Label).text = "Value: %s"%_resource._value
	
	
func _on_sell_button_pressed()->void:
	_container.sell_crystal(_index)
	
