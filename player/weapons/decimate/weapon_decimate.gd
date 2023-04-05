extends Node2D

@export var speed = 600
@export var impact_scene: PackedScene
@export var direction = Vector2(1, 0)
var velocity = Vector2()

func _ready():
	connect("body_entered", body_entered)
	velocity = direction * speed

func _process(delta):
	speed -= delta * 900
	velocity = direction * speed
	global_position += velocity * delta

func body_entered(body):
	if body.has_method("kill"):
		body.kill()

func _on_animated_sprite_2d_animation_finished():
	queue_free()
