extends Collectible

@export var heal_amount := 30

func handle_collision_with_player():
	if get_slide_collision_count() == 0:
		return
	var collided_player_ref = get_slide_collision(0).get_collider()
	collided_player_ref.heal(heal_amount)
	queue_free()
