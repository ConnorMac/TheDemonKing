extends State

@export var GroundIdle : State

func on_enter(previous_state : State):
	# Lets just default to a basic attack for now
	ground_attack()
	
func ground_attack():
	next_state = GroundIdle
