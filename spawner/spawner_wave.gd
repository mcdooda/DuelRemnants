extends Node

class_name SpawnerWave

@export var enemy_type: PackedScene
@export var timing: float
@export var distance: float = 200
@export var interval: float = 0.1
@export var minimum_amount: int = 1

func _to_string():
	var string = ""
	string += "Enemy type: " + enemy_type.resource_path + "\n"
	string += "Timing: " + str(timing) + "\n"
	string += "Distance: " + str(distance) + "\n"
	string += "Interval: " + str(interval) + "\n"
	return string
