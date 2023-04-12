extends Node

@export var spawn_settings : Array[PackedScene]

var spawn_settings_instances : Array
var next_wave_index = 0
var current_time = 0
var enemy_count = 0
@export var max_enemy_count = 200
var rng = RandomNumberGenerator.new()
@onready var player_collision = get_node("/root/level_1/PlayerCharacter/Collision")

var current_wave

func _ready():
	for wave_settings in spawn_settings:
		var wave_settings_instance = wave_settings.instantiate()
		#print(wave_settings_instance)
		spawn_settings_instances.append(wave_settings_instance)
	current_wave = spawn_settings_instances[0]
	
func _process(delta):
	if next_wave_index < spawn_settings_instances.size() and current_time >= current_wave.timing:
		setup_next_wave()
	current_time += delta

func setup_next_wave():
	print("Spawning wave:\n", current_wave)
	spawn_minimum_amount_of_enemies(current_wave.enemy_type, current_wave.minimum_amount)
	$SpawnTimer.wait_time = current_wave.interval
	next_wave_index = min(next_wave_index + 1, spawn_settings_instances.size() - 1)
	current_wave = spawn_settings_instances[next_wave_index]

func spawn_enemy(enemy_type):
	var player_position = player_collision.global_position
	var alpha = rng.randf_range(0, PI * 2)
	var wave_center = player_position + Vector2(cos(alpha), sin(alpha)) * current_wave.distance
	var enemy = enemy_type.instantiate()
	get_tree().root.add_child(enemy)
	enemy.connect("enemy_dies", decrease_enemy_count)
	enemy.global_position = wave_center + Vector2(rng.randf() - 0.5, rng.randf() - 0.5) * 200
	enemy_count += 1
	
func spawn_enemies(enemy_type, number):
	for i in number:
		spawn_enemy(enemy_type)
	
func spawn_minimum_amount_of_enemies(enemy_type, minimum_amount):
	spawn_enemies(enemy_type, minimum_amount - enemy_count)

func decrease_enemy_count():
	enemy_count -= 1

func _on_spawn_timer_timeout():
	if enemy_count < max_enemy_count:
		spawn_enemy(current_wave.enemy_type)
