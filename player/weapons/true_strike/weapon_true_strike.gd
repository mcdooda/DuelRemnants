extends Area2D

@export var direction = Vector2(1, 0)

func _ready():
	connect("body_entered", body_entered)
	$Collision.disabled = true

func body_entered(body):
	if body.has_method("kill"):
		body.kill()

func _on_animated_sprite_2d_animation_finished():
	queue_free()


func _on_animated_sprite_sprite_frames_changed():
	var current_frame = $AnimatedSprite.frame
	if current_frame == 10:
		$Collision.disabled = false


func _on_animated_sprite_frame_changed():
	var current_frame = $AnimatedSprite.frame
	if current_frame == 10:
		$Collision.disabled = false
