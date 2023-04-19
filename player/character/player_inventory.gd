extends Node

var item_list = {}
@export var max_size = 6

func random_key():
	var item_keys = item_list.keys()
	item_keys = item_keys[randi() % item_keys.size()]
	return item_keys

func add_item(item_scene, trigger_on_cooldown):
	var item_path = item_scene.resource_path
	if item_list.has(item_path):
		item_list[item_path].level_up()
	elif item_list.size() < max_size:
		var item = item_scene.instantiate()
		item.init(trigger_on_cooldown)
		item_list[item_path] = item
		add_sibling(item)
		return item

func add_instantiated_item(item):
	var scene_path = item.scene_file_path
	if item_list.has(scene_path):
		item_list[scene_path].level_up()
	else:
		item_list[scene_path] = item
		add_sibling(item)

func random_item():
	return item_list[random_key()]

func maybe_get_ability(ability_path):
	return item_list.get(ability_path)

signal item_leveled_up
