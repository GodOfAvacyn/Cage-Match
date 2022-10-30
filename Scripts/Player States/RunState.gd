extends State
class_name RunState

export var min_speed : float
export var max_speed : float
export var accel : float
export var deaccel : float

func enter_state():
	set_animation("Idle")

func process_state(delta):
	player.velocity += accel * delta * get_input_move()
	if player.velocity.length() < min_speed:
		player.velocity = min_speed * player.velocity.normalized()
	if player.velocity.length() > max_speed:
		player.velocity = max_speed * player.velocity.normalized()

func exit_state():
	return

func check_switch():
	if Input.is_action_just_pressed("attack_left"):
		sm.switch_states()
