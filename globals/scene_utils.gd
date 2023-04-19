extends Node

func find_file_with_extension_from_path(path, extension):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.get_extension() == extension:
				return path + "/" + file_name
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the item path: ", path)
	return null
	
func find_abilities_paths():
	var abilities_parent_path = "res://player/ability/abilities/"
	var dir = DirAccess.open(abilities_parent_path)
	if dir:
		var abilities_paths = dir.get_directories()
		var result: PackedStringArray = []
		for ability_root in abilities_paths:
			result.append(find_file_with_extension_from_path(abilities_parent_path + ability_root, "tscn"))
		return result
	else:
		print("An error occurred when trying to access the ability path: ", abilities_parent_path)
	return null
