extends AnimationPlayer

func _ready():
	$Timer.connect("timeout", play_animation)

func start_animation(delay: float):
	if delay > 0.0:
		play("RESET")
		$Timer.wait_time = delay
		$Timer.start()
	else: 
		play_animation()
	
func play_animation():
	play("show")
