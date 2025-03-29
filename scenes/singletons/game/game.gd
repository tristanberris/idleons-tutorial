class_name Game
extends Node
## The root node of the game

## Singleton reference
static var ref : Game

##Constructor
func _init() -> void:
	if not ref : ref = self
	else : queue_free()

##main data object of the game
var data:Data = Data.new()
