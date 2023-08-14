extends State

# Needed states
@export var GroundIdle : State
# Animations
@export var attack_windup_anim : String = "attack_windup"
@export var attack_dash_anim : String = "attack_dash"

# Attack hitbox
@onready var hitbox : Area2D

# Attack timer
@onready var attack_timer = get_node("../../AttackTimer")

func on_enter(previous_state : State):
	# Lets just default to a basic attack for now
	ground_attack_windup()

func state_process(delta):
	state_ai_action(delta)

func state_ai_action(delta):
	pass
	
func ground_attack_windup():
	playback.travel(attack_windup_anim)
	
func ground_attack():
	character.velocity.x = (character.facing_direction * character.attack_dash_speed)
	character.velocity.y = character.attack_dash_jump_speed
	# About to move into the attack dash anim
	# print("moving to dash anim")
	playback.travel(attack_dash_anim)
	attack_timer.start()

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == attack_windup_anim:
		ground_attack()
	if anim_name == attack_dash_anim:
		next_state = GroundIdle
