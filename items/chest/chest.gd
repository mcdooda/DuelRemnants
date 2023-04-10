extends Node

@export var items: Array

var rng = RandomNumberGenerator.new()
var player_ref: CharacterBody2D

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
			pass

func _on_animated_sprite_2d_animation_finished():
	if items.is_empty():
		fill_chest_randomly()

	for item in items:
		var item_instance = item.instantiate()
		get_tree().root.add_child(item_instance)
		item_instance.global_position = self.global_position
		item_instance.drop()

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_ref = body
		$Sprite.play("open")
