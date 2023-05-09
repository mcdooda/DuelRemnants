extends Node2D

class_name Level

@export var world_map: Resource


func load_world_map():
	var all_enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in all_enemies:
		enemy.queue_free()
	get_tree().change_scene_to_packed(world_map)
