extends State

@export var ground_moving_state : State
@export var attacking_state : State

@onready var player : CharacterBody2D = get_tree().get_nodes_in_group("player")[0] #TODO this better

func state_process(delta):
	state_ai_action(delta)

func state_ai_action(delta):
	# Function that defines the current AI logic for this state
	var vector_to_player : Vector2 = character.position - player.position
	var direction_to_player : Vector2 = vector_to_player.normalized()
	var distance_to_player_x : float  = abs(character.position.x - character.player.position.x)
	if distance_to_player_x <= character.sight_distance:
		trigger_alert_notification()
		next_state = ground_moving_state
	else:
		character.velocity.x = 0
		
func trigger_alert_notification():
	character.emote_handler.display_emote('Alert')
