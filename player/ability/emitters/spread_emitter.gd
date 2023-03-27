var spread_angle = PI

# Called when the node enters the scene tree for the first time.
static func emit(projectile_scene, num_projectiles, player_ref, root):
	for i in num_projectiles:
		var projectile = projectile_scene.instantiate()
		#projectile.global_position = player_ref.global_position
		projectile.direction = player_ref.direction
		root.add_child(projectile)
