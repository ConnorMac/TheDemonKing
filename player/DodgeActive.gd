extends TextureProgressBar

class_name  timer_display

@export var timer : Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	self.max_value = timer.wait_time
	self.value = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.value = timer.time_left
