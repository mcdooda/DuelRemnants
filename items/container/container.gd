extends Node

class_name ItemContainer

@export var items: Array[PackedScene]

var player_ref: CharacterBody2D

func _on_body_entered(body):
	if body.is_in_group("player_characters"):
		player_ref = body
		$Sprite.play("open")
	check_content()

func check_content():
	pass

func _on_sprite_animation_finished():
	for item in items:
		var item_instance = item.instantiate()
		get_tree().root.add_child(item_instance)
		item_instance.global_position = self.global_position
		item_instance.drop()
