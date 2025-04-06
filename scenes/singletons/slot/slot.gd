extends PanelContainer



func _on_mouse_entered():
	Popups.ItemPopup(Rect2i(Vector2i(global_position), Vector2i(size)),null)
	##This sends position and size of slot to popup

func _on_mouse_exited():
	Popups.HideItemPopup()
