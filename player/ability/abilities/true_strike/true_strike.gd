extends Ability

@export var radius = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.one_shot = true
	init_timer()
	
func trigger_ability():
	for i in num_projectiles:
		$Timer.start()
		await $Timer.timeout
		spawn_sword(i)

func spawn_sword(sword_index):
	var projectile = projectile_scene.instantiate()
	var alpha = (2 * PI) * (float(sword_index) / float(num_projectiles))
	projectile.position += Vector2(cos(alpha) * radius, sin(alpha)  * radius)
	#projectile.direction.x = cos(alpha)
	get_parent().add_child(projectile)
