extends Sprite2D

@export var character : CharacterBody2D

var start_scale_x
var start_position_x
# The base amount shifting the position - the zero value
var position_x_shift = 37 # no between 37 and 82 %
# Called when the node enters the scene tree for the first time.
func _ready():
	start_scale_x = self.scale.x
	start_position_x = self.position.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var current_hp_percentage = character.current_health / character.max_health
	# This scales the hp bar
	self.scale.x = start_scale_x * current_hp_percentage
	self.position.x = ((start_position_x - position_x_shift) * current_hp_percentage) + position_x_shift
