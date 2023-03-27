extends AnimatedSprite2D

func _ready():
	connect("animation_looped", animated_looped)
	play("small")

func animated_looped():
	get_parent().remove_child(self)
