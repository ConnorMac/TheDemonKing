extends State


# State vars
@export var air_state : State
@export var dodge_state : State
@export var attack_state : State

# Animation vars
@export var jump_animation : String = "jump_start"
@export var landing_animation : String = "land"
@export var dodge_animation : String = "rolling"

# Timers
@onready var dodge_timer = get_node("../../DodgeTimer")


func on_enter(previous_state : State):
	# Reset air vars
	character.times_attacked_in_air = 0
	character.times_jumped_in_air = 0
	# If coming from the air then land
	if previous_state == air_state:
		land()

func state_process(delta):
	if(!character.is_on_floor()):
		next_state = air_state

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		jump()
	if(event.is_action_pressed("dodge") and dodge_timer.is_stopped()) :
		dodge()
	if(event.is_action_pressed("attack")):
		attack()
		
func jump():
	playback.travel(jump_animation)
	character.velocity.y = character.jump_velocity
	next_state = air_state
	
func dodge():
	playback.travel(dodge_animation)
	next_state = dodge_state
	
func attack():
	next_state = attack_state

func land():
	playback.travel(landing_animation)
