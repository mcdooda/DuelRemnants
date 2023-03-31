extends Node2D

@export var speed = 100

@export var direction = Vector2(1, 0)
var velocity = Vector2()

func _ready():
	connect("body_entered", body_entered)
	velocity = direction * speed

func _process(delta):
	global_position += velocity * delta

func body_entered(body):
	print("entered!")
	if body.has_method("kill"):
		body.kill()
		


func _on_animated_sprite_death_animation_finished():
	queue_free()
