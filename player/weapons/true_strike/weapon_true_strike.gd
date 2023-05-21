extends Area2D

@export var direction = Vector2(1, 0)
@export var base_damage := 3
@export var base_knockback := 300

var knockback := 200
var stats: Stats

func _ready():
	connect("body_entered", body_entered)
	$Collision.disabled = true

func body_entered(body):
	if body.has_method("hit"):
		body.hit(base_knockback + stats.knockback, base_damage + stats.damage)

func _on_animated_sprite_animation_finished():
	queue_free()

func _on_animated_sprite_sprite_frames_changed():
	var current_frame = $AnimatedSprite.frame
	if current_frame == 10:
		$Collision.disabled = false

func _on_animated_sprite_frame_changed():
	var current_frame = $AnimatedSprite.frame
	if current_frame == 10:
		$Collision.disabled = false
