extends Node

func find_item_scene(item):
	var path = item.scene_file_path.get_base_dir() + "/item"
	return SceneUtils.find_file_with_extension_from_path(path, "tscn")

func find_item_animation(item):
	var path = item.scene_file_path.get_base_dir()
	path += "/item"
	return SceneUtils.find_file_with_extension_from_path(path, "tres")
