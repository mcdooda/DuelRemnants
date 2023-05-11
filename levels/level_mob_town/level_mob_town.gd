extends Level

@onready var survive_timer = get_node("CanvasLayer/SurviveTimerLabel/Timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	$Spawner.set_player_ref(player_character)
	survive_timer.connect("timeout", success)
