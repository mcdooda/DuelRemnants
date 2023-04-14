extends Ability

var radius := 30

# Called when the node enters the scene tree for the first time.
func _ready():
	init_timer()


func shoot_at(enemy_index):
	var projectile = projectile_scene.instantiate()
	add_child(projectile)
	var alpha = (2 * PI) * (enemy_index / float(num_projectiles))
	var vectorAlpha = Vector2(cos(alpha), sin(alpha))
	projectile.position = vectorAlpha * radius
	projectile.direction = vectorAlpha * radius

func trigger_ability():
	for i in num_projectiles:
			shoot_at(i)

func _process(delta):
	rotation += delta
