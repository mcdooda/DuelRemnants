extends Node2D

class_name Level

@export var world_map: Resource
@export var player_character_scene: PackedScene

var player_character: Node2D

func _ready():
	if GlobalPlayer.saved_players.is_empty():
		player_character = player_character_scene.instantiate()
		add_child(player_character)
	else:
		player_character = GlobalPlayer.saved_players[0]
		add_child(player_character)
		player_character.show()

func save_character():
	player_character.hide()
	remove_child(player_character)
	GlobalPlayer.saved_players.append(player_character)

func success():
	$Transition.global_position = player_character.global_position
	$Transition.in_transition()
	GlobalUi.connect("scene_transition_animation_finished", load_world_map)

func load_world_map():
	save_character()
	var all_enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in all_enemies:
		enemy.queue_free()
	var all_collectibles = get_tree().get_nodes_in_group("collectibles")
	for collectible in all_collectibles:
		collectible.queue_free()
	get_tree().change_scene_to_packed(world_map)
