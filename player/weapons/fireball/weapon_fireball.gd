extends Node2D

@export var speed = 600
@export var base_damage := 5
@export var base_knockback := 300
@export var impact_scene: PackedScene
@export var direction = Vector2(1, 0)
var velocity = Vector2()

func _ready():
	connect("body_entered", body_entered)
	velocity = direction * speed

func _process(delta):
	global_position += velocity * delta

func body_entered(body):
	if body.has_method("hit"):
		body.hit(base_knockback, base_damage)
		var impact_vfx = impact_scene.instantiate()
		impact_vfx.global_position = global_position
		impact_vfx.set_flip_h($Sprite.is_flipped_h())
		get_tree().root.add_child(impact_vfx)

func _on_life_timer_timeout():
	queue_free()
