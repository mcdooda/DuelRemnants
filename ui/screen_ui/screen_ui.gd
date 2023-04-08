extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().connect("size_changed", compute_size)
	size = get_viewport().get_visible_rect().size
	$experience_bar.compute_size()
	
func compute_size():
	size = get_viewport().get_visible_rect().size
	$experience_bar.compute_size()
