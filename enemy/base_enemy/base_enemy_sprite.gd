extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	material = material.duplicate()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var velocity = get_parent().velocity
	
	if velocity.x != 0:
		set_flip_h(velocity.x < 0)
	var pos_y = get_parent().position.y
	if pos_y > RenderingServer.CANVAS_ITEM_Z_MAX:
		z_index = RenderingServer.CANVAS_ITEM_Z_MAX
	elif pos_y < RenderingServer.CANVAS_ITEM_Z_MIN:
		z_index = RenderingServer.CANVAS_ITEM_Z_MIN
	else:
		z_index = pos_y
		
	if animation == "death":
		return
		
	if velocity.length_squared() > 0:
		play("move")
	else:
		play("idle")
