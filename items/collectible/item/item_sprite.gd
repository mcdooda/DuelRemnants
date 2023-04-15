extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	play("default")
	# dont reorder their z index: it's better if they stay behind the units
	# z_index = get_parent().position.y
