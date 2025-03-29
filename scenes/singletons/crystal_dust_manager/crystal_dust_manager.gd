class_name CrystalDustManager
extends Node
## Manages Crystal Dust Resource

## Singleton Reference
static var ref:CrystalDustManager

## Constructor
func _init()->void:
	if not ref:ref=self
	else:queue_free()


## Emitted when crystal dust is updated
signal updated

var resources : DataResources = Game.ref.data.resources

## Return the current amount of crystal dust owned
func value()->int:
	return resources.crystal_dust 

## Creates crystal dust. Requires a quantity argument.
func create(quantity:int)->Error:
	if quantity <= 0:return FAILED
	
	resources.crystal_dust += quantity
	updated.emit()
	
	return OK
	
## Tries to consume some amount of Crystal Dust. 
## The consumption can be forced. If so, it will empty the remaining crystal dust.
func consume(quantity:int, forced:bool = false)->Error:
	if quantity < 0 : return FAILED
	
	if quantity > value() and not forced : return FAILED
	
	resources.crystal_dust -= quantity
	if resources.crystal_dust < 0 : resources.crystal_dust = 0
	updated.emit()
	
	return OK
