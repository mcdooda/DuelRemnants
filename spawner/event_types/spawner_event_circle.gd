extends SpawnerEvent

@export var block_enemy: PackedScene
@export var radius := 400
@export var num_enemies := 60
var rng := RandomNumberGenerator.new()

func spawn_units(wave_center):
	var enemy = enemy_type.instantiate()
	enemy.global_position = wave_center + Vector2(rng.randf() - 0.5, rng.randf() - 0.5) * 200
	get_tree().root.add_child(enemy)
	spawn_block_enemies(wave_center)

func spawn_block_enemies(wave_center):
	for i in num_enemies:
		var enemy = block_enemy.instantiate()
		var alpha = (2 * PI) * (i / float(num_enemies))
		enemy.global_position = wave_center + Vector2(cos(alpha) * radius, sin(alpha) * radius)
		get_tree().root.add_child(enemy)
