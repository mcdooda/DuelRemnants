extends Evolution

@export var chest_scene: PackedScene

func enter_map_action():
	for i in 10:
		var chest = chest_scene.instantiate()
		chest.global_position = Vector2i(randi_range(-30, 30), randi_range(-30, 30))
		get_tree().root.add_child(chest)
