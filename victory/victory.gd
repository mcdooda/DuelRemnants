extends Node2D

@export var world_map: Resource

func _ready():
	GlobalUi.connect("item_selected", on_evolution_selected)

func on_evolution_selected(evolution: Node):
	WorldMapData.add_evolution(evolution)
	evolution.select()
	get_tree().change_scene_to_file("res://world_map/world_map.tscn")
