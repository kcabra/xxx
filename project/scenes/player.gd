extends KinematicBody

var speed = 2
var gravity = 0.001
var jump = 0.05


onready var cam = get_tree().get_nodes_in_group("camera")[0]
const JUMP_TOLERANCE = 0.3
const FLOOR = Vector3.UP
const FLOOR_TOLERANCE = 45
var input_vec : Vector2 = Vector2.ZERO
var input_jumped : float = 0
var move_grounded : float = 0
var move_vec : Vector3 = Vector3.ZERO


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		elif Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	if event.is_action_pressed("move_forward"):
		input_vec.y += 1
	if event.is_action_pressed("move_left"):
		input_vec.x += 1
	if event.is_action_pressed("move_backward"):
		input_vec.y -= 1
	if event.is_action_pressed("move_right"):
		input_vec.x -= 1

	if event.is_action_released("move_forward"):
		input_vec.y -= 1
	if event.is_action_released("move_left"):
		input_vec.x -= 1
	if event.is_action_released("move_backward"):
		input_vec.y += 1
	if event.is_action_released("move_right"):
		input_vec.x += 1


func _physics_process(delta):
	var aux = move_vec.y
	move_vec = cam.transform.basis.z * input_vec.y * speed * delta
	move_vec += cam.transform.basis.x * input_vec.x * speed * delta
	move_vec.y = aux
	
	if input_vec.y > 0:
		self.rotation.y = cam.rotation.y
	elif input_vec.y < 0:
		self.rotation.y = cam.rotation.y + PI
	if input_vec.x > 0:
		self.rotation.y = cam.rotation.y + PI/2
	elif input_vec.x < 0:
		self.rotation.y = cam.rotation.y - PI/2
	
	if Input.is_action_just_pressed("move_jump"):
		input_jumped = JUMP_TOLERANCE
	elif Input.is_action_just_released("move_jump") and move_vec.y > 0:
		move_vec.y /= 1.5
	input_jumped -= delta
	move_grounded -= delta
	if input_jumped > 0 and move_grounded > 0:
		move_vec.y = jump
		input_jumped = 0
		move_grounded = 0
	else:
		move_vec.y -= gravity
	var col = move_and_collide(move_vec)
	if col:
		if sin(col.normal.y) > sin(deg2rad(FLOOR_TOLERANCE)):
			move_grounded = JUMP_TOLERANCE
			move_vec.y = 0
		move_and_collide(col.remainder.slide(col.normal))