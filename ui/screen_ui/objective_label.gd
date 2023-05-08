extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	$ObjectiveLabelTimer.connect("timeout", objective_disappear)
	$ObjectiveLabelTimer.start()

func objective_disappear():
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.5)
