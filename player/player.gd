extends CharacterBody2D


#const SPEED = 200.0
#const JUMP_VELOCITY = -350.0

# Player specific vars
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO
var facing_direction : float

# Movement var
@export var jump_velocity = -350.0
@export var air_jump_velocity = -200.0
@export var roll_velocity = 300.0
@export var number_of_air_jumps = 1
@export var number_of_air_attacks = 1
@export var movement_speed = 200.0

# Damage values
var ground_attack = 10
var air_attack = 10

# Internal check values
var times_attacked_in_air = 0
var times_jumped_in_air = 0

# Player Node objects
@onready var sprite : Sprite2D = $Sprite2D # Player Sprite sheet
@onready var animation_tree : AnimationTree = $AnimationTree # Animation control
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

# States
@export var dodge_state : State

func _ready():
	# Set the animations as active
	animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() && state_machine.current_state.gravity_enabled:
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "ui_up", "ui_down")
	if direction && state_machine.current_state.can_move:
		velocity.x = sign(direction.x) * movement_speed
	elif state_machine.current_state != dodge_state:
		velocity.x = move_toward(velocity.x, 0, movement_speed)
	

	move_and_slide()
	update_animation_parameters()
	update_facing_direction()
	

func update_animation_parameters():
	# Use the Animation Tree Move Blend space to adjust between run and idle
	animation_tree.set("parameters/Move/blend_position", sign(direction.x))

func update_facing_direction():
	if state_machine.current_state.can_change_direction:
		if direction.x > 0:
			sprite.flip_h = false
			facing_direction = 1
		if direction.x < 0:
			sprite.flip_h = true
			facing_direction = -1
