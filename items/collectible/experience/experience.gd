extends Collectible

@export var experience_value = 1

func handle_collision_with_player():
	if get_slide_collision_count() == 0:
		return
	GlobalExperience.add_experience(experience_value)
	queue_free()
