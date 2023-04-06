extends Node2D

@export var speed = 100
@export var base_damage := 5
@export var base_knockback := 300

@export var direction = Vector2(1, 0)
var velocity = Vector2()

func _ready():
	connect("body_entered", body_entered)
	velocity = direction * speed
	$Collision.disabled = true

func _process(delta):
	global_position += velocity * delta

func body_entered(body):
	if body.has_method("hit"):
		body.hit(base_knockback, base_damage)

func _on_animated_sprite_death_animation_finished():
	queue_free()

func _on_animated_sprite_spawn_animation_finished():
	$Collision.disabled = false
