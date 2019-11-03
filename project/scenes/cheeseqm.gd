extends Area

var got : bool = false
onready var player = get_tree().get_nodes_in_group("player")[0]

func _ready():
	$AnimationPlayer.play("spin")

func _get_player():
	var pa = get_tree().get_nodes_in_group("player")
	player = pa[0] if pa.size() > 0 else null

func _on_player_entered(body):
	if !got and body == player:
		got = true
		$AnimationPlayer.play("fade")
		var ui = get_tree().get_nodes_in_group("ui")[0]
		ui.value += 1
		if ui.value == ui.max_value:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			get_tree().change_scene("res://scenes/victory.tscn")