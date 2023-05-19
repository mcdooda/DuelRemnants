extends Node2D

class_name  Evolution

@onready var modifiers = $Modifiers
@export var card_name : String

func _ready():
	WorldMapData.connect("enter_map", enter_map_action)

func enter_map_action(_map):
	pass
