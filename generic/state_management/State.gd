extends Node

class_name State

@export var can_move : bool = true
@export var can_take_damage : bool = true
@export var can_change_direction : bool = true
@export var gravity_enabled : bool = true

var character : CharacterBody2D
var next_state : State
var playback : AnimationNodeStateMachinePlayback

signal interupt_state(new_state : State)

func state_process(delta):
	pass

func state_input(event : InputEvent):
	pass
	
func on_enter(previous_state : State):
	pass
	
func on_exit():
	pass
