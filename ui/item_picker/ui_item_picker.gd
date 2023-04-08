extends Control

var player_ref

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalExperience.connect("level_changed", on_level_changed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_level_changed():
	var picked_items = ItemSelector.pick_random_items(player_ref, 3)
	pass
