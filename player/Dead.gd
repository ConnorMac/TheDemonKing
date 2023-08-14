extends State

@export var dead_animation : String = "dead"

func on_enter(previous_state):
	# Play the death animation
	playback.travel(dead_animation)
