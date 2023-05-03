extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func compute_size():
	size = get_viewport().get_visible_rect().size
	$TopLeft.size = size / 3 + Vector2(2, 2)
	$TopLeft.position = Vector2(0, 0)
	$TopCenter.size = size / 3 + Vector2(2, 2)
	$TopCenter.position = Vector2(size.x / 3, 0)
	$TopRight.size = size / 3 + Vector2(2, 2)
	$TopRight.position = Vector2(size.x * 2 / 3, 0)
	$MiddleLeft.size = size / 3 + Vector2(2, 2)
	$MiddleLeft.position = Vector2(0, size.y / 3)
	$MiddleCenter.size = size / 3 + Vector2(2, 2)
	$MiddleCenter.size = size / 3 + Vector2(2, 2)
	$MiddleCenter.position = Vector2(size.x / 3, size.y / 3)
	$MiddleRight.size = size / 3 + Vector2(2, 2)
	$MiddleRight.position = Vector2(size.x * 2 / 3, size.y / 3)
	$BottomLeft.size = size / 3 + Vector2(2, 2)
	$BottomLeft.position = Vector2(0, size.y * 2 / 3)
	$BottomCenter.size = size / 3 + Vector2(2, 2)
	$BottomCenter.position = Vector2(size.x / 3, size.y * 2 / 3)
	$BottomRight.size = size / 3 + Vector2(2, 2)
	$BottomRight.position = Vector2(size.x * 2 / 3, size.y * 2 / 3)

func in_transition():
	compute_size()
	position -= size / 2
	$AnimationPlayer.play("show")
	$AnimationPlayer.connect("animation_finished", transition_finished)
	
func out_transition():
	compute_size()
	position -= size / 2
	$AnimationPlayer.play("out")
	$AnimationPlayer.connect("animation_finished", transition_finished)
	
func transition_finished(_name):
	GlobalUi.emit_signal("scene_transition_animation_finished")
