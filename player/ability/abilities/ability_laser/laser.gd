extends Ability

var enemies_in_range: Array
var radius = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	init_timer()
	connect("body_entered", body_entered)

func body_entered(body):
	if body.is_in_group("enemies"):
		enemies_in_range.push_back(body)
		
func shoot_at(enemy_index):
	var projectile = projectile_scene.instantiate()
	player_ref.add_child(projectile)
	var foo = (2 * PI) * (float(enemy_index) / float(num_projectiles))
	projectile.position = Vector2(cos(foo) * radius, sin(foo)  * radius)
	projectile.direction = enemies_in_range[enemy_index].position - projectile.global_position

func trigger_ability():
	if not enemies_in_range.is_empty():
		for i in num_projectiles:
			if enemies_in_range.size() > i:
				shoot_at(i)
			else:
				shoot_at(enemies_in_range.back())
