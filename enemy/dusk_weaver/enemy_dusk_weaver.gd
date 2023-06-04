extends BaseEnemy

func _ready():
	super()
	target = null
	remove_from_group("enemy")

func _on_area_2d_body_entered(_body):
	emit_signal("shop_entered")

func set_text(text: String):
	$Bubble.set_text(text)

func set_angry_text(text: String):
	$Bubble.set_shacky_text(text)

signal shop_entered
