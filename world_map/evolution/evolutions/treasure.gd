extends Evolution

@export var chest_scene: PackedScene
@export var num_chests := 10

func map_entered(map):
	for i in num_chests:
		var chest = chest_scene.instantiate()
		chest.global_position = Vector2i(randi_range(-150, 150), randi_range(-150, 150))
		map.add_child(chest)
