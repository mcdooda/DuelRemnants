extends Node

var item_list = []
@export var max_size = 6

func add_item(item_scene):
	if item_list.size() < max_size:
		var item = item_scene.instantiate()
		item.init()
		item_list.push_back(item)
		add_child(item)
