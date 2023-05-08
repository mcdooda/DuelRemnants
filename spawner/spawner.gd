extends Node

@export var spawn_settings : Array[PackedScene]
@export var event_settings : Array[PackedScene]
@export var max_distance_allowed := 4000

var spawn_settings_instances : Array
var event_instances: Array
var wave_index := 0
var event_index := 0
var current_time := 0.0
var enemy_count := 0
var rng := RandomNumberGenerator.new()
@export var max_enemy_count := 200

var current_wave
var player_ref: CharacterBody2D

func _ready():
	for wave_settings in spawn_settings:
		spawn_settings_instances.append(wave_settings.instantiate())
	for event in event_settings:
		var event_instance = event.instantiate()
		add_child(event_instance)
		event_instances.append(event_instance)

	if spawn_settings_instances.size() > 0:
		current_wave = spawn_settings_instances[0]
	else:
		print("Current level have no waves!")

	if event_instances.size() > 0:
		$EventTimer.wait_time = event_instances[0].timing
		$EventTimer.start()

func set_player_ref(player: CharacterBody2D):
	player_ref = player

func handle_next_wave():
	if wave_index < spawn_settings_instances.size() - 1 and current_time >= spawn_settings_instances[wave_index + 1].timing:
		setup_next_wave()

func _process(delta):
	current_time += delta
	handle_next_wave()

func setup_next_wave():
	print("Spawning wave:\n", current_wave)
	spawn_minimum_amount_of_enemies(current_wave.enemy_type, current_wave.minimum_amount)
	$SpawnTimer.wait_time = current_wave.interval
	wave_index += 1
	if wave_index < spawn_settings_instances.size():
		current_wave = spawn_settings_instances[wave_index]

func player_position():
	return player_ref.global_position

func compute_out_of_screen_position():
	var position = player_position()
	var radius = max(get_viewport().get_visible_rect().size.x, get_viewport().get_visible_rect().size.y)
	var alpha = rng.randf_range(0, 2 * PI)
	return position + Vector2(cos(alpha) * radius, sin(alpha) * radius)

func spawn_enemy(enemy_type):
	var out_of_screen_position = compute_out_of_screen_position()
	var enemy = enemy_type.instantiate()
	get_tree().root.add_child(enemy)
	enemy.connect("enemy_dies", decrease_enemy_count)
	enemy.global_position = out_of_screen_position
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

func _on_event_timer_timeout():
	event_instances[event_index].spawn_units(compute_out_of_screen_position(), player_position())
	event_index += 1
	if event_index < event_instances.size():
		$EventTimer.wait_time = event_instances[event_index].timing
		$EventTimer.start()

# kill all enemies that are too far away from the player
func _on_garbage_timer_timeout():
	var all_enemies = get_tree().get_nodes_in_group("enemies")
	var max_distance_squared = max_distance_allowed * max_distance_allowed
	for enemy in all_enemies:
		if player_ref.global_position.distance_squared_to(enemy.global_position) > max_distance_squared:
			print("Removing ", enemy)
			enemy.kill(true)
