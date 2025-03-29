class_name FirstScene
extends Control

#var data:Data = Game.ref.data

func _ready() -> void:
	update_label()
	(get_node("Button") as Button).pressed.connect(_on_button_pressed)
	IdleonsManager.ref.idleons_updated.connect(_on_idleons_updated)


func update_label() -> void:
	(get_node("Label") as Label).text = "Idleons: %s"%IdleonsManager.ref.get_idleons()
	
func create_idleons() -> void:
#	data.resources.idleons += 5
	IdleonsManager.ref.create_idleons(5)
	update_label()
	
	
func _on_button_pressed() -> void:
	create_idleons()
	(get_node("Label") as Label).text = "Idleons: %s"%IdleonsManager.ref.get_idleons()
	

func _on_idleons_updated()-> void:
	update_label()
