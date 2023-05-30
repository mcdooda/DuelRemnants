extends Node2D

@export var world_map: Resource
@onready var evolution_picker = get_node("CanvasLayer/EvolutionPicker")

func _ready():
	$CanvasLayer.remove_child(evolution_picker)
	GlobalUi.connect("item_selected", on_evolution_selected)

func on_evolution_selected(evolution: Node):
	WorldMapData.add_evolution(evolution)
	evolution.select()
	get_tree().change_scene_to_file("res://world_map/world_map.tscn")

func _on_animated_sprite_2d_animation_finished():
	$CanvasLayer.add_child(evolution_picker)
	evolution_picker.focus_first_item()
	pass # Replace with function body.
