extends Ability

# Called when the node enters the scene tree for the first time.
func _ready():
	init_timer()

func trigger_ability():
	for i in num_projectiles:
		var projectile = projectile_scene.instantiate()
		projectile.global_position = get_parent().global_position
		projectile.position += get_parent().muzzle.position
		projectile.direction = get_parent().direction
		projectile.direction.y = 0
		if projectile.direction.x == 0:
			projectile.direction.x = 1
		get_tree().root.add_child(projectile)
