extends Camera2D

@export var camera_speed := 600

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	position += input_direction * delta * camera_speed
