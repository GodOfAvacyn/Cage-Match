extends AnimatedSprite


var player: AnimationPlayer

func _ready():
	player = get_node("AnimationPlayer")
	if player is AnimationPlayer:
		player.current_animation = "idle"
	play()
