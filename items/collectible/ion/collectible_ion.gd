extends Collectible

func handle_collision_with_player():
	if get_slide_collision_count() == 0:
		return
	var collided_player_ref = get_slide_collision(0).get_collider()
	var experience_orbs = get_tree().get_nodes_in_group("experience")
	for experience_orb in experience_orbs:
		experience_orb.move_to(collided_player_ref)
	queue_free()
