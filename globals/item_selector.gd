extends Node

func get_all_scenes_from_path(path):
	var result = []
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
			file_name = dir.get_next()
			if file_name.get_extension() == "tscn":
				result.push_back(file_name)
	else:
		print("An error occurred when trying to access the path.")
	return result

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_all_scenes_from_path(res://player/ability/abilities/)
	
	#var all_scenes = load(res://path/to/scene.tscn)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func pick_random_items(_player_ref, _num):
	pass
