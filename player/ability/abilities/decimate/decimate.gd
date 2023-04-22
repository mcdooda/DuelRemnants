extends Ability

@export var max_angle := 2 * PI

# Called when the node enters the scene tree for the first time.
func _ready():
	init_timer()

func trigger_ability():
	var projectile_number = max_projectiles()
	for i in projectile_number:
		var alpha = (-max_angle / 2.0) + (i / float(projectile_number)) * max_angle
		var projectile = projectile_scene.instantiate()
		projectile.global_position = get_parent().global_position
		projectile.direction = Vector2(cos(alpha), sin(alpha))
		get_tree().root.add_child(projectile)
