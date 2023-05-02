extends AnimatedSprite2D

var event_children: Array = []
var sorted_children: Array[int] = []
var index := 0

func sort_children():
	for i in event_children.size():
		sorted_children.push_back(i)
	sorted_children.sort_custom(y_comparison)
	
func y_comparison(a, b):
	return event_children[a].global_position.y > event_children[b].global_position.y

# Called when the node enters the scene tree for the first time.
func assign_event_children(event: MapEvent):
	index = 0
	event_children = event.children
	sort_children()
	if not event_children.is_empty():
		change_position()
	else:
		print("Can't move cursor to child event: no child event")

func selected_event():
	return event_children[sorted_children[index]]

func change_position():
	global_position = selected_event().global_position

func assign_to_next():
	index += 1
	if index >= sorted_children.size():
		index = 0
	change_position()

func assign_to_previous():
	index -= 1
	if index < 0:
		index = sorted_children.size() - 1
	change_position()
