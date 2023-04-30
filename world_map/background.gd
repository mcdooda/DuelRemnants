extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().connect("size_changed", resize_to_screen_size)
	resize_to_screen_size()
	pass # Replace with function body.

func resize_to_screen_size():
	region_rect = Rect2(Vector2(0, 0), get_viewport().get_visible_rect().size)
