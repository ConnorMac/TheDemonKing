extends Button

@export var scene_to_load : PackedScene

func _on_pressed():
	get_tree().change_scene_to_packed(scene_to_load)
