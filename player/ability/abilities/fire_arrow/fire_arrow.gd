extends Ability

@export var max_angle := PI / 4

# Called when the node enters the scene tree for the first time.
func _ready():
	init_timer()

func trigger_ability():
	var max_projectiles = num_projectiles + modifiers.num_projectiles
	for i in max_projectiles:
		var alpha = (-max_angle / 2.0) + ((i + 1)/ float(max_projectiles + 1)) * max_angle
		var projectile = projectile_scene.instantiate()
		projectile.global_position = get_parent().global_position
		projectile.position += get_parent().muzzle.position
		#var alpha = rng.randf_range(-max_angle / 2, max_angle / 2)
		var parent_direction = get_parent().direction
		if parent_direction.x == 0:
			parent_direction.x = 1
		projectile.direction = Vector2(parent_direction.x * cos(alpha), sin(alpha))
		#projectile.direction.y = 0
		#if projectile.direction.x == 0:
		#	projectile.direction.x = 1
		get_tree().root.add_child(projectile)
