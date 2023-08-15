extends Node2D

# Local vars
var current_emote : Node

# Timer for hiding the current emote
@onready var emote_timer : Timer = $EmoteTimer

func display_emote(emote):
	if has_node(emote):
		emote = get_node(emote)
		current_emote = emote
		emote.show()
		emote_timer.start()

func _on_emote_timer_timeout():
	current_emote.hide()
