extends SpawnerEvent

@export var radius := 400
@export var num_enemies := 60
var rng := RandomNumberGenerator.new()

func spawn_units(wave_center):
	print("spawn event units")
	for i in num_enemies:
		var enemy = enemy_type.instantiate()
		enemy.global_position = wave_center + Vector2(rng.randf() - 0.5, rng.randf() - 0.5) * 200
		enemy.direction = wave_center
		get_tree().root.add_child(enemy)
