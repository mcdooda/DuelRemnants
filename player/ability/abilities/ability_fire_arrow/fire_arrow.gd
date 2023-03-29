extends Ability

# Called when the node enters the scene tree for the first time.
func _ready():
	init_timer()
	speed = 1
	
func trigger_ability():
	for i in num_projectiles:
		var projectile = projectile_scene.instantiate()
		#projectile.global_position = player_ref.global_position
		projectile.direction = player_ref.direction
		get_tree().root.add_child(projectile)
