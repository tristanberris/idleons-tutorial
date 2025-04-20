extends Control

# Pre-load the children nodes for easy access.
@onready var tab_buttons = $TabButtons.get_children()
@onready var pages = $Pages
#var VerticalTabsScene = preload("MarginContainer/HBoxContainer/RightPanel")
signal tab_changed(index)

# Assume the rest of your tab logic is here...

func _ready():
	# For each button, connect the signal using a lambda (anonymous function)
	for button in tab_buttons:
		button.pressed.connect(Callable(self, "_on_tab_pressed").bind(button))
	_show_page(0)  # Show the first page by default

func _on_tab_pressed(button):
	# Get the index of the pressed button
	var index = tab_buttons.find(button)
	_show_page(index)
	emit_signal("tab_changed", index)

func _show_page(index):
	# Loop through each page. Display only the page that matches the index.
	for i in range(pages.get_child_count()):
		var page = pages.get_child(i)
		page.visible = (i == index)
	# Now, toggle the VBoxContainer's visibility so that it shows only on the first tab.
	# Here, we assume that index 0 corresponds to the first tab.
	#my_vbox.visible = (index == 0)	
