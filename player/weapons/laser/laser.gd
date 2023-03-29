extends RayCast2D

# Speed at which the laser extends when first fired, in pixels per seconds.
@export var cast_speed := 8.0
# Maximum length of the laser in pixels.
@export var max_length := 100.0
# Base duration of the tween animation in seconds.
@export var growth_time := 0.2

# If `true`, the laser is firing.
# It plays appearing and disappearing animations when it's not animating.
# See `appear()` and `disappear()` for more information.
var is_casting := false : set = set_is_casting

@export var direction: Vector2
@export var impact_scene: PackedScene

@onready var fill := $Line2D
@onready var casting_particles := $EmitingParticles

@onready var line_width: float = fill.width

func _ready():
	set_physics_process(false)
	fill.points[1] = Vector2.ZERO
	self.is_casting = true

func _physics_process(delta: float):
	target_position = (target_position + direction * cast_speed * delta)#.limit_length(max_length)
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

# Controls the emission of particles and extends the Line2D to target_position` or the ray's 
# collision point, whichever is closest.
func cast_beam():
	var cast_point := target_position
	force_raycast_update()

	if is_colliding():
		cast_point = to_local(get_collision_point())
		var impact_vfx = impact_scene.instantiate()
		impact_vfx.global_position = get_collision_point()
		impact_vfx.global_rotation = get_collision_normal().angle()
		get_tree().root.add_child(impact_vfx)
		var collided_object = get_collider()
		if collided_object.has_method("hit"):
			collided_object.hit()
	else:
		cast_point = target_position
	fill.points[1] = cast_point

func appear():
	var tween = create_tween()
	tween.tween_property(fill, "width", 3, growth_time).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	$Timer.connect("timeout", disappear)
	$Timer.start()

func disappear():
	var tween = create_tween()
	tween.tween_property(fill, "width", 0, growth_time).connect("finished", queue_free)
