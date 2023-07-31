extends Node

class_name CharacterStateMachine

@export var current_state : State
@export var character : CharacterBody2D
@export var animation_tree : AnimationTree

var states : Array[State]
var facing_direction : bool
var previous_state : State

func _ready():
	for child in get_children():
		if (child is State):
			states.append(child)
			
			# Set the states up with the data they need to function
			child.character = character
			child.playback = animation_tree["parameters/playback"]
			
			# Connect to interupt signal
			child.connect("interupt_state", on_state_interupt_state)
			child.connect("facing_direction_change", _on_player_facing_direction_change)
		else:
			push_warning("Child " + child.name + " is not a state")
			
func _physics_process(delta):
	if(current_state.next_state != null):
		switch_states(current_state.next_state)

	current_state.state_process(delta)

func check_if_can_move():
	return current_state.can_move

func switch_states(new_state : State):
	if (current_state != null):
		current_state.on_exit()
		current_state.next_state = null
	
	previous_state = current_state
	current_state = new_state
	current_state.on_enter(previous_state)

func _input(event : InputEvent):
	current_state.state_input(event)
	
func on_state_interupt_state(new_state : State):
	switch_states(new_state)

func _on_player_facing_direction_change(facing_right):
	facing_direction = facing_right
