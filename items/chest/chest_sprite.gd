extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	play("default")
	pass # Replace with function body.


func _on_chest_body_entered(body):
	if body.is_in_group("player"):
		play("open")
