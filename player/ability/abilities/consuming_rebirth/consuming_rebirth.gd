extends Ability

# Called when the node enters the scene tree for the first time.
func _ready():
	init_timer()

func trigger_ability():
	for i in num_projectiles:
		var projectile = projectile_scene.instantiate()
		projectile.global_position = get_parent().global_position
		projectile.direction = get_parent().get_parent().direction
		get_tree().root.add_child(projectile)
