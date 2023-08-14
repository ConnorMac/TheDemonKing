extends Node

class_name Damageable

# Get the top level character 2D object
@export var character : CharacterBody2D

signal on_hit(node : Node, damage_taken : int, knockback_direction : Vector2)
		
@export var dead_animation_name : String = "dead"

func hit(damage : int, knockback_direction : Vector2):
	if character.state_machine.current_state.can_take_damage:
		character.current_health -= damage
		
		emit_signal("on_hit", get_parent(), damage, knockback_direction)


func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == dead_animation_name):
		# Remove instance that finished dead anim from the game
		# We want to make a special case for the player
		get_parent().queue_free()
