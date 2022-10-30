extends Node
class_name State

var sm : StateMachine
var player : PlayerController
func _ready():
	sm = get_parent()
	player = sm.get_parent()

func get_input_move():
	var input_move = Vector2.ZERO;
	if (Input.is_action_pressed("move_up")): input_move.y -= 1;
	if (Input.is_action_pressed("move_down")): input_move.y += 1;
	if (Input.is_action_pressed("move_left")): input_move.x -= 1;
	if (Input.is_action_pressed("move_right")): input_move.x += 1;
	return input_move.normalized()

func set_animation(animation):
	var animator = player.get_node("AnimatedSprite").get_node("AnimationPlayer")
	if animator is AnimationPlayer:
		animator.current_animation = animation
