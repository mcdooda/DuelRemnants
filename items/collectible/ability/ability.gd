extends Collectible

@export var item: PackedScene

func handle_collision_with_player():
	if get_slide_collision_count() == 0:
		return
	var collided_player_ref = get_slide_collision(0).get_collider()
	collided_player_ref.inventory.add_item(item, true)
	queue_free()
