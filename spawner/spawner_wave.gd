extends Node

class_name SpawnerWave

@export var enemy_type: PackedScene
@export var number: int
@export var timing: float
@export var distance: float = 200

func _to_string():
	var string = ""
	string += "Enemy type: " + enemy_type.resource_path + "\n"
	string += "Number: " + str(number) + "\n"
	string += "Timing: " + str(timing) + "\n"
	string += "Distance: " + str(distance) + "\n"
	return string
