extends HitState

@export var hit_anim : String = "hit"
@export var damage_box : Area2D

func on_enter(previous_state):
	# Play the death animation
	damage_box.monitoring = false
	super(previous_state)
	
func on_exit():
	# Play the death animation
	damage_box.monitoring = true
	super()

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == hit_anim:
		next_state = return_state
