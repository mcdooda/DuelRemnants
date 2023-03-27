extends Ability

# Called when the node enters the scene tree for the first time.
func _ready():
	init_timer()
	speed = 1
	root = player_ref
