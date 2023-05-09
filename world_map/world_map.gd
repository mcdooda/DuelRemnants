extends Node

const plane_len = 1200
@export var path_count = 5
@export var distance_between_points = 200

const map_scale = 20.0

var events = {}
@export var event_scene: PackedScene
@onready var transition = get_node("Camera/Transition")

func _ready():
	WorldMapData.save_state()
	var generator = preload("res://world_map/generator.gd").new()
	var map_data = generator.generate(plane_len, distance_between_points, path_count)

	for k in map_data.nodes.keys():
		var point = map_data.nodes[k]
		var event = event_scene.instantiate()
		event.position = point + Vector2(100, 0)
		$Props.add_sibling(event)
		events[k] = event
	
	for path in map_data.paths:
		for i in range(path.size() - 1):
			var index1 = path[i]
			var index2 = path[i + 1]
			events[index1].add_child_event(events[index2], index2)
			events[index1].randomize_type(i)
	initialize_player_position()
	$Camera.global_position = $Pawn.global_position
	$Pawn.connect("objective_reached", start_scene_transition)
	GlobalUi.connect("scene_transition_animation_finished", load_level)

func initialize_player_position():
	if WorldMapData.current_player_node:
		$Pawn.global_position = events[WorldMapData.current_player_node].global_position
		$Cursor.assign_event_children(events[WorldMapData.current_player_node])
	else:
		$Pawn.global_position = events[0].global_position
		$Cursor.assign_event_children(events[0])

func start_scene_transition():
	transition.in_transition()

func load_level():
	var event_index = $Cursor.selected_event_index()
	if event_index != 0:
		WorldMapData.reset_state()
		WorldMapData.change_player_node(event_index)
		get_tree().change_scene_to_file("res://levels/level_mob_town/level_mob_town.tscn")

func _unhandled_input(event):
	if $Pawn.is_moving():
		return
	if event is InputEventKey:
		if Input.is_action_pressed("Up"):
			$Cursor.assign_to_next()
		elif Input.is_action_pressed("Down"):
			$Cursor.assign_to_previous()
		elif Input.is_action_pressed("ui_accept"):
			$Pawn.move_to_event(events[$Cursor.selected_event_index()])
