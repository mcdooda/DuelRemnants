extends Node

@export var items: Array

func _on_animated_sprite_2d_animation_finished():
	for item in items:
		for i in item[1]:
			var item_instance = item[0].instantiate()
			get_tree().root.add_child(item_instance)
			item_instance.global_position = self.global_position
			item_instance.drop()

