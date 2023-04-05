
extends AnimatedSprite2D

func _ready():
	play("default")
	z_index = get_parent().get_parent().global_position.y
	set_flip_h(get_parent().direction.x < 0)
