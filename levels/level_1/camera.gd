extends Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Transition.z_index = 1
	$Transition.out_transition()
