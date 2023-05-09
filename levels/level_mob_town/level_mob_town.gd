extends Level

@onready var survive_timer = get_node("CanvasLayer/SurviveTimerLabel/Timer")
@onready var transition = get_node("PlayerCharacter/Transition")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Spawner.set_player_ref($PlayerCharacter)
	survive_timer.connect("timeout", success)

func success():
	GlobalUi.connect("scene_transition_animation_finished", load_world_map)
	transition.in_transition()
