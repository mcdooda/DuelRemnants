extends RayCast2D

# Speed at which the laser extends when first fired, in pixels per seconds.
@export var cast_speed := 3000.0
# Maximum length of the laser in pixels.
@export var max_length := 200.0
# Base duration of the tween animation in seconds.
@export var growth_time := 0.1

# If `true`, the laser is firing.
# It plays appearing and disappearing animations when it's not animating.
# See `appear()` and `disappear()` for more information.
var is_casting := false : set = set_is_casting

@export var direction: Vector2

@onready var fill := $Line2D
@onready var casting_particles := $EmitingParticles
@onready var collision_particles := $ImpactParticles
@onready var beam_particles := $BeamParticles

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
		collision_particles.emitting = false
		disappear()

	set_physics_process(is_casting)
	beam_particles.emitting = is_casting
	casting_particles.emitting = is_casting
	casting_particles.global_rotation = direction.angle()

# Controls the emission of particles and extends the Line2D to target_position` or the ray's 
# collision point, whichever is closest.
func cast_beam():
	var cast_point := target_position

	force_raycast_update()
	collision_particles.emitting = is_colliding()

	if is_colliding():
		cast_point = to_local(get_collision_point())
		collision_particles.global_rotation = get_collision_normal().angle()
		collision_particles.position = cast_point
	else:
		cast_point = target_position
		collision_particles.global_rotation = direction.angle()
		collision_particles.position = cast_point
	fill.points[1] = cast_point
	beam_particles.position = cast_point * 0.5
	beam_particles.process_material.emission_box_extents.x = cast_point.length() * 0.5

func appear():
	var tween = create_tween()
	tween.tween_property(fill, "width", 3, growth_time * 5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	$Timer.connect("timeout", disappear)
	$Timer.start()


func disappear():
	var tween = create_tween()
	tween.tween_property(fill, "width", 0, growth_time).connect("finished", queue_free)
