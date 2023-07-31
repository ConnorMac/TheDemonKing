extends State

# States that can initiate attacks
@export var ground_state : State
@export var air_state : State
@export var dodging_state : State

# Attack animations
@export var ground_attack_anim : String = "ground_attack"
@export var air_attack_anim : String = "air_attack"

var return_state : State

func on_enter(previous_state : State):
	if previous_state == dodging_state:
		# Default to ground after roll
		return_state = ground_state
	else:
		return_state = previous_state
	if previous_state in [ground_state, dodging_state]:
		ground_attack()
	if previous_state == air_state:
		air_attack()

func ground_attack():
	playback.travel(ground_attack_anim)

func air_attack():
	# Set the vertical movement to 0
	character.velocity.y = 0
	playback.travel(air_attack_anim)

func _on_animation_tree_animation_finished(anim_name):
	# Once any attack animations complete go back to the previous state
	if anim_name in [ground_attack_anim, air_attack_anim]:
		next_state = return_state
