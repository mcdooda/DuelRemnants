extends SpawnerEvent

@export var radius := 400
@export var num_enemies := 60

func spawn_units(out_of_screen_position, player_position):
	for i in num_enemies:
		var enemy = enemy_type.instantiate()
		enemy.global_position = out_of_screen_position
		enemy.position.x += i
		enemy.position.y += i
		enemy.direction = player_position - enemy.global_position
		get_tree().root.add_child(enemy)
