extends Area2D

@export var experience_value = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", on_body_entered)

func on_body_entered(_body):
	queue_free()
