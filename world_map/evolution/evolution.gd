extends Node2D

class_name  Evolution

@onready var stats = $Modifiers
@export var card_name : String

func select():
	WorldMapData.connect("enter_map", map_entered)
	selected(GlobalPlayer.saved_players)

func map_entered(_map):
	pass

func selected(_players: Array[PlayerCharacter]):
	pass
