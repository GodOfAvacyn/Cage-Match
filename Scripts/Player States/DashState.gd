extends State
class_name DashState

func enter_state():
	return

func process_state(delta):
	var input_move = player.get_input_move()
	var previous_speed = player.velocity.length()
	player.velocity += player.accel * delta * input_move
	player.velocity = previous_speed * player.velocity.normalized()
	player.velocity -= player.dash_deaccel * delta * player.velocity.normalized()
	player.position += delta * player.velocity
	if player.velocity.length() <= player.max_speed:
		return

func exit_state():
	return

func check_switch():
	return
