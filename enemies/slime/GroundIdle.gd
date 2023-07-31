extends State

@export var GroundMoving : State

@onready var player : CharacterBody2D = get_tree().get_nodes_in_group("player")[0] #TODO this better


func state_process(delta):
	state_ai_action(delta)


func state_ai_action(delta):
	# Function that defines the current AI logic for this state
	var vector_to_player : Vector2 = character.position - player.position
	var direction_to_player : Vector2 = vector_to_player.normalized()
	var distance_to_player_x : float  = abs(character.position.x - character.player.position.x)
	if distance_to_player_x <= character.sight_distance:
		next_state = GroundMoving
	else:
		character.velocity.x = 0
