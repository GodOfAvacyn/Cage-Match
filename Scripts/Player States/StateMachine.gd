extends Node
class_name StateMachine

var state: State

func _ready():
	state = get_child(0)

func _process(delta):
	state.update_state(delta)

func switch_states(new_state):
	state.exit_state()
	new_state.enter_state()
	state = new_state

func idle() -> State:
	return state

func run() -> State:
	return state
