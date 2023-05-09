extends Control

class_name SceneTransition

var rects := []
@export var width := 8
@export var height := 8
@export var duration := 0.8

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in width:
		rects.append([])
		rects[x] = []
		for y in height:
			rects[x].append([])
			rects[x][y] = ColorRect.new()
			rects[x][y].color = Color(0, 0, 0, 0)
			add_child(rects[x][y])
	compute_size_and_position()
	var animation_library: AnimationLibrary = $AnimationPlayer.get_animation_library("default")
	var in_animation = create_animation(Color(0, 0, 0, 0), Color.BLACK)
	animation_library.add_animation("in", in_animation)
	var out_animation = create_animation(Color.BLACK, Color(0, 0, 0, 0))
	animation_library.add_animation("out", out_animation)
	$AnimationPlayer.connect("animation_finished", transition_finished)

func update_rects():
	for x in rects.size():
		for y in rects[x].size():
			# add 1 to handle cast loss
			var rect_size = Vector2i(int(size.x / width) + 1, int(size.y / height) + 1)
			rects[x][y].size = rect_size
			rects[x][y].position = Vector2(x * rect_size.x, y * rect_size .y)

func compute_size_and_position():
	var new_size = get_viewport().get_visible_rect().size
	if size != new_size:
		size = new_size
		update_rects()

func create_animation(start: Color, end: Color):
	var animation = Animation.new()
	animation.length = duration + 0.5
	var total_size : float = width + height
	for x in rects.size():
		for y in rects[x].size():
			var track_index = animation.add_track(Animation.TYPE_VALUE)
			animation.track_set_path(track_index, "/" + rects[x][y].get_path().get_concatenated_names() + ":color")
			var animation_start = ((x + y) / total_size) * duration
			animation.track_insert_key(track_index, animation_start, start)
			animation.track_insert_key(track_index, animation_start + 0.5, end)
	return animation

func in_transition():
	compute_size_and_position()
	position = -size / 2
	$AnimationPlayer.play("default/in")
	
func out_transition():
	compute_size_and_position()
	position = -size / 2
	$AnimationPlayer.play("default/out")
	
func transition_finished(_name):
	GlobalUi.emit_signal("scene_transition_animation_finished")
