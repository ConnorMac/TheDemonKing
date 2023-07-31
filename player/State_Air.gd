extends State

@export var ground_state : State
@export var attack_state : State

@export var in_air_animation : String = "in_air"
@export var jump_animation : String = "jump_start"

var times_jumped_in_air = 0
var times_attacked_in_air = 0

func on_enter(previous_state):
	# If velocity is downwards then set to falling
	if character.velocity.y >= 0:
		print("playing in air")
		playback.travel(in_air_animation)

func on_exit():
	# Zero out checker vars
	times_jumped_in_air = 0
	times_attacked_in_air= 0

func state_process(delta):
	if(character.is_on_floor()):
		next_state = ground_state
	if character.velocity.y >= 0:
		playback.travel(in_air_animation)

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		jump()
	if(event.is_action_pressed("attack")):
		attack()
		
func jump():
	# Function handls the air jumping logic
	if character.times_jumped_in_air < character.number_of_air_jumps:
		playback.travel(jump_animation)
		character.velocity.y = character.air_jump_velocity
		character.times_jumped_in_air += 1

func attack():
	if character.times_attacked_in_air < character.number_of_air_attacks:
		character.times_attacked_in_air += 1
		next_state = attack_state
