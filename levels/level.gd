extends Node2D

class_name Level

@export var victory_map: Resource
@export var player_character_scene: PackedScene

@onready var transition = get_node("CanvasLayer/Transition")

var player_character: Node2D

func _ready():
	if GlobalPlayer.saved_players.is_empty():
		player_character = player_character_scene.instantiate()
		add_child(player_character)
	else:
		player_character = GlobalPlayer.saved_players[0]
		add_child(player_character)
	player_character.global_position = Vector2i(0, 0)
	WorldMapData.emit_signal("enter_map", self)

func save_character():
	remove_child(player_character)
	GlobalPlayer.saved_players.append(player_character)

func success():
	GlobalUi.connect("scene_transition_animation_finished", load_world_map)
	transition.in_transition()

func load_world_map():
	save_character()
	var all_enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in all_enemies:
		enemy.queue_free()
	var all_collectibles = get_tree().get_nodes_in_group("collectibles")
	for collectible in all_collectibles:
		collectible.queue_free()
	get_tree().change_scene_to_packed(victory_map)

