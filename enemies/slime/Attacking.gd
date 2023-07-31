extends State

@export var GroundIdle : State

func on_enter(previous_state : State):
	# Lets just default to a basic attack for now
	ground_attack()

func state_process(delta):
	state_ai_action(delta)

func state_ai_action(delta):
	pass
	
func ground_attack():
	# Wind up animation
	# On windup animation finish dash through player
	character.velocity.x = (character.facing_direction * character.attack_dash_speed)
	next_state = GroundIdle
