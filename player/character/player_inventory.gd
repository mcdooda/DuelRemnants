extends Node

var item_list = []
@export var max_size = 6

func add_item(item_scene):
	if item_list.size() < max_size:
		print ("Add item")
		var item = item_scene.instantiate()
		item.init(get_parent())
		item_list.push_back(item)
		add_child(item)
		

