extends Node2D

const plane_len = 3000
@export var path_count = 5
@export var distance_between_points = 180

const map_scale = 20.0

var events = {}
@export var event_scene: PackedScene

func _ready():
	var generator = preload("res://world_map/generator.gd").new()
	var map_data = generator.generate(plane_len, distance_between_points, path_count)

	for k in map_data.nodes.keys():
		var point = map_data.nodes[k]
		var event = event_scene.instantiate()
		event.position = point + Vector2(100, 0)
		add_child(event)
		events[k] = event
	
	for path in map_data.paths:
		for i in range(path.size() - 1):
			var index1 = path[i]
			var index2 = path[i + 1]
			
			events[index1].add_child_event(events[index2])
			events[index1].randomize_type(i)

	$Pawn.global_position = events[0].global_position
	$Cursor.assign_event_children(events[0])
	$Pawn.connect("objective_reached", load_level)
	$Pawn.z_index = 2
	$Cursor.z_index = 1

func load_level():
	var selected_objective = $Pawn.objective_event
	if selected_objective != events[0]:
		get_tree().change_scene_to_file("res://levels/level_1/level_1.tscn")

func _unhandled_input(event):
	if $Pawn.is_moving():
		return
	if event is InputEventKey:
		if Input.is_action_pressed("Up"):
			$Cursor.assign_to_next()
		elif Input.is_action_pressed("Down"):
			$Cursor.assign_to_previous()
		elif Input.is_action_pressed("ui_accept"):
			$Pawn.move_to_event($Cursor.selected_event())
