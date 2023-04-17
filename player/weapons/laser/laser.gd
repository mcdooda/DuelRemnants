extends RayCast2D

# Speed at which the laser extends when first fired, in pixels per seconds.
@export var cast_speed := 8.0
# Maximum length of the laser in pixels.
@export var max_length := 100.0
# Base duration of the tween animation in seconds.
@export var growth_time := 0.2

@export var base_damage := 1
@export var base_knockback := 10


# If `true`, the laser is firing.
# It plays appearing and disappearing animations when it's not animating.
# See `appear()` and `disappear()` for more information.
var is_casting := false : set = set_is_casting

var direction: Vector2
@export var impact_scene: PackedScene

@onready var fill := $Line2D
@onready var casting_particles := $EmitingParticles
@onready var impact_particles := $ImpactParticles

@onready var line_width: float = fill.width

func _ready():
	set_physics_process(false)
	fill.points[1] = Vector2.ZERO
	self.is_casting = true

func _physics_process(delta: float):
	target_position = (target_position + direction * cast_speed * delta).limit_length(max_length)
	cast_beam()

func set_is_casting(cast: bool):
	is_casting = cast
	if is_casting:
		target_position = Vector2.ZERO
		fill.points[1] = target_position
		appear()
	else:
		disappear()

	set_physics_process(is_casting)
	casting_particles.emitting = is_casting
	casting_particles.global_rotation = direction.angle()
	impact_particles.emitting = is_casting
	impact_particles.global_rotation = direction.angle()

func cast_beam():
	var cast_point := target_position
	force_raycast_update()

	if is_colliding():
		cast_point = to_local(get_collision_point())
		var collided_object = get_collider()
		if collided_object.has_method("hit"):
			collided_object.hit(base_knockback, base_damage)
	else:
		cast_point = target_position
	fill.points[1] = cast_point
	impact_particles.position = cast_point

func appear():
	var tween = create_tween()
	tween.tween_property(fill, "width", 5, growth_time).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	$Timer.connect("timeout", disappear)
	$Timer.start()

func disappear():
	var tween = create_tween()
	tween.tween_property(fill, "width", 0, growth_time).connect("finished", queue_free)
