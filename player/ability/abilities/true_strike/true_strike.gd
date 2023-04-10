extends Ability

@export var radius = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.one_shot = true
	init_timer()
	
func trigger_ability():
	var total_projectiles = num_projectiles + modifiers.num_projectiles
	for i in total_projectiles:
		$Timer.start()
		await $Timer.timeout
		spawn_sword(i)

func spawn_sword(sword_index):
	var projectile = projectile_scene.instantiate()
	var alpha = (2 * PI) * (float(sword_index) / float(num_projectiles + modifiers.num_projectiles))
	projectile.position += Vector2(cos(alpha) * radius, sin(alpha)  * radius)
	projectile.modifiers = modifiers
	get_parent().add_child(projectile)
