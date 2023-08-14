extends State

class_name HitState

@export var damageable : Damageable
@export var character_state_machine : CharacterStateMachine
@export var dead_state : State
@export var hit_animation : String = "hit"
@export var knockback_speed : float = 100.0
@export var return_state : State

@onready var timer : Timer = $Timer

func _ready():
	damageable.connect("on_hit", on_damageable_hit)
	
func on_enter(previous_state):
	if timer:
		timer.start()
	playback.travel(hit_animation)

# Interrupts any state if the damagable signal is fired
func on_damageable_hit(node : Node, damage_amount : int, knockback_direction : Vector2):
	if(character.current_health > 0):
		character.velocity = Vector2.ZERO
		emit_signal("interupt_state", self)
	else:
		emit_signal("interupt_state", dead_state)
		
func on_exit():
	character.velocity = Vector2.ZERO

func _on_timer_timeout():
	next_state = return_state
