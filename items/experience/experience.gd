extends CharacterBody2D

@export var experience_value = 1
@export var max_speed = 400

var player_ref
var current_speed = -400

func move_to(player):
	player_ref = player

func _physics_process(_delta):
	if player_ref == null:
		return
	
	var target_position = player_ref.global_position
	var self_position = global_position
	if current_speed < max_speed:
		current_speed += _delta * 2000
	var direction = target_position - self_position
	velocity = direction.normalized() * current_speed
	move_and_slide()
	handle_collision_with_player()

func handle_collision_with_player():
	if get_slide_collision_count() == 0:
		return
	GlobalExperience.add_experience(experience_value)
	queue_free()
