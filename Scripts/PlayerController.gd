extends Area2D;
class_name PlayerController

# Serialized
export var min_speed : float
export var max_speed : float
export var accel : float
export var deaccel : float
export var dash_force : float
export var dash_deaccel : float

# Private
var state: String
var velocity : Vector2
var glove : CollisionShape2D
var buffer : String

func _ready():
	state = "idle"


func _process(delta):
	if state == "idle":
		idle(delta)
	if state == "punch":
		punch(delta)
	if state == "dash":
		dash(delta)


func idle(delta):
	# Attack handling
	if (Input.is_action_just_pressed("attack_left")):
		var collider = get_node("GloveCollider")
		if collider is CollisionShape2D:
			collider.disabled = false
		set_animation("punch_left")
		punch(delta)
		state = "punch"
		return
	if (Input.is_action_just_pressed("attack_right")):
		var collider = get_node("GloveCollider")
		if collider is CollisionShape2D:
			collider.disabled = false
		set_animation("punch_right")
		punch(delta)
		state = "punch"
		return
	
	var input_move = get_input_move()

	# Dash handling
	if (Input.is_action_just_pressed("dash") or buffer == "dash"):
		velocity = dash_force * input_move
		dash(delta)
		state = "dash"
		return
	
	if (input_move == Vector2.ZERO):
		if (velocity.length() <= min_speed): velocity = Vector2.ZERO
		else: velocity -=  deaccel * delta * velocity.normalized()
	else:
		velocity += accel * delta * input_move
		if (velocity.length() >= max_speed): velocity = velocity.normalized() * max_speed
	
	position += delta * velocity;


func punch(delta):
	if Input.is_action_just_pressed("dash"):
		buffer = "dash"
	if (velocity.length() <= min_speed): velocity = Vector2.ZERO
	else: velocity -=  deaccel * delta * velocity.normalized()
	position += delta * velocity
	var collider = get_node("GloveCollider")
	if collider is CollisionShape2D:
		if collider.disabled:
			state = "idle"
			set_animation("idle")

func dash(delta):
	buffer = ""
	print(velocity)
	var input_move = get_input_move()
	var previous_speed = velocity.length()
	velocity += accel * delta * input_move
	velocity = previous_speed * velocity.normalized()
	velocity -= dash_deaccel * delta * velocity.normalized()
	position += delta * velocity
	if velocity.length() <= max_speed:
		state = "idle"

func set_animation(animation):
	var animator = get_node("AnimatedSprite").get_node("AnimationPlayer")
	if animator is AnimationPlayer:
		animator.current_animation = animation

func get_input_move():
	var input_move = Vector2.ZERO;
	if (Input.is_action_pressed("move_up")): input_move.y -= 1;
	if (Input.is_action_pressed("move_down")): input_move.y += 1;
	if (Input.is_action_pressed("move_left")): input_move.x -= 1;
	if (Input.is_action_pressed("move_right")): input_move.x += 1;
	return input_move.normalized()
