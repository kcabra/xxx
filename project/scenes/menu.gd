extends CanvasLayer

func _ready():
	$Button.connect("pressed", self, "on_button_pressed")
	$Tween.connect("tween_completed", self, "tween_ended")
	$Tween.interpolate_property($xxx, "rect_position:y",
			$xxx.rect_position.y, ($xxx.rect_position.y - 200),
			5.0, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($xxx2, "rect_position:y",
			$xxx2.rect_position.y, ($xxx2.rect_position.y - 150),
			2.7, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.4)
	$Tween.start()


func on_button_pressed():
	get_tree().get_nodes_in_group("camera")[0].get_children()[0].get_children()[0].current = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	for child in get_children():
		if child is CanvasItem:
			child.visible = false
	get_tree().get_nodes_in_group("ui")[0].get_parent().visible = true

var q1 = false
var q2 = false
func tween_ended(obj, _path):
	match obj.name:
		"xxx":
			if q1:
				$Tween.interpolate_property($xxx, "rect_position:y",
						$xxx.rect_position.y, ($xxx.rect_position.y - 200),
						5.0, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				q1 = !q1
			else:
				$Tween.interpolate_property($xxx, "rect_position:y",
						$xxx.rect_position.y, ($xxx.rect_position.y + 200),
						5.0, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				q1 = !q1
		"xxx2":
			if q2:
				$Tween.interpolate_property($xxx2, "rect_position:y",
						$xxx2.rect_position.y, ($xxx2.rect_position.y - 150),
						5.0, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				q2 = !q2
			else:
				$Tween.interpolate_property($xxx2, "rect_position:y",
						$xxx2.rect_position.y, ($xxx2.rect_position.y + 150),
						5.0, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				q2 = !q2
	$Tween.start()