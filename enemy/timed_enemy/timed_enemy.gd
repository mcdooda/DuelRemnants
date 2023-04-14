extends BaseEnemy

func _on_life_timer_timeout():
	$Sprite.play("death")
