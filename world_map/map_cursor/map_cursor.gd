extends AnimatedSprite2D

var event_children := {}
var sorted_children: Array[int] = []
var index := 0

func sort_children():
	sorted_children.clear()
	for i in event_children:
		sorted_children.push_back(i)
	sorted_children.sort_custom(y_comparison)
	
func y_comparison(a, b):
	return event_children[a].global_position.y > event_children[b].global_position.y

func assign_event_children(event: MapEvent):
	index = 0
	event_children = event.children
	sort_children()
	if not event_children.is_empty():
		change_position()
	else:
		print("Can't move cursor to child event: no child event")

func selected_event_index():
	return sorted_children[index]

func change_position():
	global_position = event_children[selected_event_index()].global_position

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
