extends Node

@export var spawn_settings : Array[PackedScene]

var spawn_settings_instances : Array
var next_wave_index = 0
var current_time = 0
var rng = RandomNumberGenerator.new()
@onready var player_collision = get_node("/root/level_1/PlayerCharacter/Collision")

func _ready():
	for wave_settings in spawn_settings:
		var wave_settings_instance = wave_settings.instantiate()
		#print(wave_settings_instance)
		spawn_settings_instances.append(wave_settings_instance)

func _process(delta):
	while next_wave_index < spawn_settings_instances.size() and current_time >= spawn_settings_instances[next_wave_index].timing:
		spawn_wave(spawn_settings_instances[next_wave_index])
		next_wave_index += 1
	
	current_time += delta

func spawn_wave(wave_settings):
	print("Spawning wave:\n", wave_settings)
	var player_position = player_collision.global_position
	var alpha = rng.randf_range(0, PI * 2)
	var wave_center = player_position + Vector2(cos(alpha), sin(alpha)) * wave_settings.distance
	
	for enemy_index in range(wave_settings.number):
		var enemy = wave_settings.enemy_type.instantiate()
		enemy.global_position = wave_center + Vector2(rng.randf() - 0.5, rng.randf() - 0.5) * 200
		get_tree().root.add_child(enemy)
