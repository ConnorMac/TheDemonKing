extends State

# State
@export var ground_state : State
@export var attack_state : State

# Anim names
@export var dodging_animation : String = "rolling"

# func on_enter(previous_state : State):
	# Give the players accel a slight boost on dodge
	# character.velocity.x += (character.dodge_accel_boost * character.direction.x)
	# print(character.velocity.x)
	
func state_process(delta):
	# Give the dodge some oomf
	character.velocity.x = (character.facing_direction * character.roll_velocity)

func state_input(event : InputEvent):
	# Attack can interrupt dodge
	if(event.is_action_pressed("attack")):
		attack()	

func attack():
	next_state = attack_state

func _on_animation_tree_animation_finished(anim_name):
	# If the roll animation is finished go back to the ground state
	print(anim_name)
	if anim_name == dodging_animation:
		print('setting ground state next')
		next_state = ground_state
