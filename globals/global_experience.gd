extends Node

var current_experience = 0
var current_level = 1
var required_experience

func _ready():
	compute_required_experience()

func add_experience(value):
	emit_signal("experience_changed")
	current_experience += value
	while current_experience > required_experience:
		current_experience -= required_experience
		compute_required_experience()
		level_up()

func compute_required_experience():
	required_experience = round(pow(current_level, 2) + current_level * 2)

func level_up():
	current_level += 1
	emit_signal("level_changed")
	
signal level_changed
signal experience_changed
