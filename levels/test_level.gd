extends Node2D

var level_done : bool = false

# Enemy spawning base classes
@export var slime_base : PackedScene

func _ready():
	# Set the animations as active
	$RetryMenu.hide()
	$YouWon.hide()
	
func _process(delta):
	# Check each loop if the game has actually ended
	if not get_tree().get_nodes_in_group("enemies") and not level_done:
		level_done = true
		$YouWon.show()

func _input(event : InputEvent):
	if event is InputEventKey:
		if event.pressed && event.keycode == KEY_R:
			# Some fun debug slime spawning
			var slime = slime_base.instantiate()
			slime.add_to_group("enemies")
			add_child(slime) 
			slime.position = get_global_mouse_position()

func _on_player_player_has_died(dead):
	$RetryMenu.show()
