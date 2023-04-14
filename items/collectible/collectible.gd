extends CharacterBody2D

class_name Collectible

@export var max_speed = 400

var player_ref
var current_speed = -400
var rng = RandomNumberGenerator.new()

func move_to(player):
	player_ref = player

func _physics_process(_delta):
	if player_ref:
		var target_position = player_ref.global_position
		var self_position = global_position
		if current_speed < max_speed:
			current_speed += _delta * 2000
		var direction = target_position - self_position
		velocity = direction.normalized() * current_speed
	move_and_slide()
	handle_collision_with_player()

func handle_collision_with_player():
	pass

func drop():
	#velocity = Vector2(rng.randf_range(-100.0, 100.0), rng.randf_range(-100.0, 100.0))
	pass

