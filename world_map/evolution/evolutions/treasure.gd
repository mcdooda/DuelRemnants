extends Evolution

@export var chest_scene: PackedScene

func enter_map_action(map):
	for i in 10:
		var chest = chest_scene.instantiate()
		chest.global_position = Vector2i(randi_range(-100, 100), randi_range(-100, 100))
		map.add_child(chest)
