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
		
	z_index = get_parent().position.y
		
	if animation == "death":
		return
		
	if velocity.length_squared() > 0:
		play("move")
	else:
		play("idle")
