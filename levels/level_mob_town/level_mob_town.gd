extends Level

@onready var survive_timer = get_node("CanvasLayer/SurviveTimerLabel/Timer")

func _ready():
	super()
	$Spawner.set_player_ref(player_character)
	survive_timer.connect("timeout", success)
