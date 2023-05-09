extends Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = "%d:%02d" % [floor($Timer.time_left / 60), int($Timer.time_left) % 60]
	pass
