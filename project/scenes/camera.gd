extends Camera

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var camera = get_tree().get_nodes_in_group("camera")[0]
onready var rot_help = $".."

const MOUSE_SENSITIVITY = 0.003

func _input(event):
	if event is InputEventMouseMotion && Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
#		player.rotate_y(event.relative.x * MOUSE_SENSITIVITY * -1)
		camera.rotate_y(event.relative.x * MOUSE_SENSITIVITY * -1)
		rot_help.rotate_x(event.relative.y * MOUSE_SENSITIVITY)
		rot_help.rotation_degrees.x = clamp(rot_help.rotation_degrees.x, -30, 70)

func _process(delta):
	camera.translation.x = player.translation.x
	camera.translation.z = player.translation.z
	camera.translation.y = lerp(camera.translation.y, player.translation.y, 0.3)