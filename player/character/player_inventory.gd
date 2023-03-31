extends Node

var item_list = []
@export var max_size = 6

func add_item(item_scene):
	if item_list.size() < max_size:
		var item = item_scene.instantiate()
		item.init(get_parent())
		item_list.push_back(item)
		get_parent().add_child(item)
