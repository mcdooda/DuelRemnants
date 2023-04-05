extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", on_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_body_entered(body):
	if body.has_method("move_to"):
		body.move_to(get_parent())
