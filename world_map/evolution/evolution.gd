extends Node2D

class_name  Evolution

@onready var modifiers = $Modifiers
@export var card_name : String

func _ready():
	WorldMapData.connect("enter_map", map_entered)
	selected()

func map_entered(_map):
	pass

func selected():
	pass
