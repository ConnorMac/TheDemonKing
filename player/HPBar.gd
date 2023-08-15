extends TextureProgressBar

@export var character : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	self.max_value = character.max_health
	self.value = character.max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.value = character.current_health
