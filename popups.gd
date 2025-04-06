extends Control

func ItemPopup(slot : Rect2i,item):
	
	var mouse_pos = get_viewport().get_mouse_position()
	var mouse_pos_i = Vector2i(mouse_pos.x, mouse_pos.y)
	var correction
	
	if mouse_pos.x <= get_viewport_rect().size.x/2:
		correction = Vector2i(slot.size.x, 0)
	else:
		correction = -Vector2i(%ItemPopup.size.x, 0)
		
	%ItemPopup.popup(Rect2i(slot.position + correction, %ItemPopup.size))
	pass
func HideItemPopup():
	%ItemPopup.hide()
