extends CharacterBody2D


const SPEED = 25.0
const JUMP_VELOCITY = -400.0

# Core nodes
@onready var sprite : Sprite2D = $Sprite2D # Player Sprite sheet
@onready var animation_tree : AnimationTree = $AnimationTree # Animation control
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
@onready var emote_handler : Node = $EmotesHandler
# A bit of a hack to get the player in the "player" group
@onready var player : CharacterBody2D = get_tree().get_nodes_in_group("player")[0]

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Local vars
var facing_direction : float
var sight_distance : float = 200.0
var movement_speed: float = 25.0
var attack_dash_speed: float = 200.0
var attack_dash_jump_speed: float = -200.0

# Health update handler
@export var max_health : float = 20
@export var current_health : float = 20:
	get:
		return current_health
	set(value):
		SignalBus.emit_signal("on_health_changed", self, value - current_health)
		current_health = value
# Need to figure out python like props
var is_alive : bool = true:
	get:
		return true if current_health > max_health else false

func _ready():
	# Set the animations as active
	animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# The "AI" for the slime. This will move into the different states.
	# update_slime_action()
	# Basic movement and sliding godot script
	move_and_slide()
	# Quick way of moving between idle and move
	update_animation_parameters()
	# Flip the sprite
	update_facing_direction()
	
func update_slime_action():
	# Get direction to player and move that way
	# We ideally want to move the state of the slime here based on it's logic
	var vector_to_player : Vector2 = position - player.position
	var direction_to_player : Vector2 = vector_to_player.normalized()
	var distance_to_player_x : float  = abs(position.x - player.position.x)
	if distance_to_player_x <= sight_distance:
		# Logic for if the slime sees the player
		if direction_to_player && distance_to_player_x > 25:
			velocity.x = sign(direction_to_player.x) * -1 * SPEED
		else:
			# We want to initiate an attack here
			velocity.x = 0
	else:
		velocity.x = 0

func update_animation_parameters():
	# Use the Animation Tree Move Blend space to adjust between run and idle
	animation_tree.set("parameters/Move/blend_position", sign(velocity.x))
	
func update_facing_direction():
	if velocity.x < 0:
		sprite.flip_h = false
		facing_direction = -1
	if velocity.x > 0:
		sprite.flip_h = true
		facing_direction = 1


func _on_damage_box_body_entered(body):
	pass # Replace with function body.
