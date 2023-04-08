extends Node

var item_list = []
@export var max_size = 6

func add_item(item_scene, trigger_on_cooldown):
	if item_list.size() < max_size:
		var item = item_scene.instantiate()
		item.init(trigger_on_cooldown)
		item_list.push_back(item)
		add_sibling(item)
		return item
