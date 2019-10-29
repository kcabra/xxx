extends CanvasLayer

func _ready():
	$Button.connect("pressed", self, "on_button_pressed")
	$Tween.interpolate_property($xxx, "rect_position:y",
			$xxx.rect_position.y, ($xxx.rect_position.y - 200),
			5.0, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($xxx2, "rect_position:y",
			$xxx2.rect_position.y, ($xxx2.rect_position.y - 150),
			5.0, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 2.0)
	$Tween.start()

func on_button_pressed():
	print_debug("DEBUG: menu button pressed!")
	get_tree().get_nodes_in_group("camera")[0].get_children()[0].get_children()[0].current = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	for child in get_children():
		if child is CanvasItem and child.name != ColorRect:
			child.visible = false
	
