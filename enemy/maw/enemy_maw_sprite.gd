extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var velocity = get_parent().velocity
	
	if velocity.x != 0:
		set_flip_h(velocity.x < 0)
		
	if velocity.length_squared() > 0:
		play("move")
	else:
		play("idle")
