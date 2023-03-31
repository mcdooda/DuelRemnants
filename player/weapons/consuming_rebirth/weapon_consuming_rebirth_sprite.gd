extends AnimatedSprite2D


func _ready():
	z_index = get_parent().position.y
	set_flip_h(get_parent().direction.x < 0)
	connect("animation_finished", play_move_animation)
	$Timer.connect("timeout", play_death_animation)
	
func play_move_animation():
	play("move")
	$Timer.start()

func play_death_animation():
	play("death")
	connect("animation_finished", kill_me)
	
func kill_me():
	emit_signal("death_animation_finished")

signal death_animation_finished
	
