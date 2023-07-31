extends State

@export var GroundIdle : State
@export var Attacking : State

@onready var player : CharacterBody2D = get_tree().get_nodes_in_group("player")[0] #TODO this better

func state_process(delta):
	state_ai_action(delta)


func state_ai_action(delta):
	# Function that defines the current AI logic for this state
	var vector_to_player : Vector2 = character.position - player.position
	var direction_to_player : Vector2 = vector_to_player.normalized()
	var distance_to_player_x : float  = abs(character.position.x - character.player.position.x)
	
	# Fist check if we should move back to idle
	if distance_to_player_x > character.sight_distance:
		next_state = GroundIdle
		return
	if direction_to_player && distance_to_player_x > 25:
		character.velocity.x = sign(direction_to_player.x) * -1 * character.movement_speed
	else:
		# We want to initiate an attack here
		character.velocity.x = 0
		next_state = Attacking
