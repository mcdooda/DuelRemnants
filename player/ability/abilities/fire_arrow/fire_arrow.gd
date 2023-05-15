extends Ability

@export var max_angle := PI / 4

# Called when the node enters the scene tree for the first time.
func _ready():
	init_timer()

func trigger_ability():
	var projectile_number = num_projectiles + modifiers.num_projectiles
	for i in projectile_number:
		var alpha = (-max_angle / 2.0) + ((i + 1)/ float(projectile_number + 1)) * max_angle
		var projectile = projectile_scene.instantiate()
		projectile.global_position = get_parent().global_position
		projectile.position += get_parent().muzzle.position
		var parent_direction = get_parent().direction
		if parent_direction.x == 0:
			parent_direction.x = 1
		projectile.direction = Vector2(parent_direction.x * cos(alpha), sin(alpha))
		get_tree().root.add_child(projectile)
