extends Ability

var enemies_in_range: Array
var radius = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	init_timer()
	connect("body_entered", body_entered)
	connect("body_exited", body_exited)

func body_entered(body):
	if body.is_in_group("enemies"):
		enemies_in_range.push_back(body)

func body_exited(body):
	if body.is_in_group("enemies"):
		enemies_in_range.erase(body)

func shoot_at(enemy_index):
	var projectile = projectile_scene.instantiate()
	add_child(projectile)
	var alpha = (2 * PI) * (enemy_index / float(num_projectiles))
	projectile.position = Vector2(cos(alpha) * radius, sin(alpha)  * radius)
	projectile.direction = enemies_in_range[enemy_index].global_position - projectile.global_position

func trigger_ability():
	if not enemies_in_range.is_empty():
		for i in num_projectiles:
			if enemies_in_range.size() > i:
				shoot_at(i)
