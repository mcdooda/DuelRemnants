extends BaseEnemy

func drop_item():
	var dropped_item = drop_item_scene.instantiate()
	dropped_item.global_position = global_position
	get_tree().root.add_child(dropped_item)
