extends State

@export var dead_animation : String = "dead"
@export var damage_box : Area2D

func on_enter(previous_state):
	# Play the death animation
	damage_box.monitoring = false
	playback.travel(dead_animation)

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == dead_animation:
		character.queue_free()
