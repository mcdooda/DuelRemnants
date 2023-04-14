extends ItemContainer

var rng = RandomNumberGenerator.new()

func item_scene(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.get_extension() == "tscn":
				return path + "/" + file_name
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path: ", path)
	return null

func fill_chest_randomly():
	var num_items = rng.randi_range(1, 5)
	for i in num_items:
		var item = player_ref.inventory.random_item()
		var maybe_item_scene = item_scene(item.scene_file_path.get_base_dir() + "/item")
		if maybe_item_scene:
			items.push_back(ResourceLoader.load(maybe_item_scene))

func check_content():
	if player_ref != null and items.is_empty():
		fill_chest_randomly()
