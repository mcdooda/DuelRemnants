extends Node

@export var items: Array

var rng = RandomNumberGenerator.new()
var player_ref: CharacterBody2D

func fill_chest_randomly():
	#var num_items = rng.randi_range(1, 5)
	#for i in num_items:
		#var item_scene = player_ref.inventory.random_item().item_scene
	pass

func _on_animated_sprite_2d_animation_finished():
	if items.is_empty():
		fill_chest_randomly()

	for item in items:
		for i in item[1]:
			var item_instance = item[0].instantiate()
			get_tree().root.add_child(item_instance)
			item_instance.global_position = self.global_position
			item_instance.drop()

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_ref = body
		$Sprite.play("open")
