extends AnimatedSprite2D

var event_children: Array = []
var index := 0

# Called when the node enters the scene tree for the first time.
func assign_event_children(event: MapEvent):
	event_children = event.children
	if not event_children.is_empty():
		change_position()
	else:
		print("Can't move cursor to child event: no child event")

func selected_event():
	return event_children[index]

func change_position():
	global_position = event_children[index].global_position

func assign_to_next():
	index += 1
	if index >= event_children.size():
		index = 0
	change_position()

func assign_to_previous():
	index -= 1
	if index < 0:
		index = event_children.size() - 1
	change_position()
