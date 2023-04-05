extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().connect("size_changed", compute_size)
	#$experience_bar.compute_size(get_viewport().size / 2)
	
func compute_size():
	size = get_viewport().size / 2
