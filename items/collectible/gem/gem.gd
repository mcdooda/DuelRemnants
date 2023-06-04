extends Collectible

@export var value = 1

func handle_collision_with_player():
	if get_slide_collision_count() == 0:
		return
	GlobalPlayer.total_money += value
	queue_free()

