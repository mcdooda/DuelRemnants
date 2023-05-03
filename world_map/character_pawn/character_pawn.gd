extends CharacterBody2D

var objective_event: MapEvent

@export var speed := 100

func move_to_event(event: MapEvent):
	objective_event = event
	pass

func is_moving():
	return velocity != Vector2(0, 0)

func _physics_process(delta):
	if objective_event == null:
		return
	if global_position.distance_squared_to(objective_event.global_position) < 9:
		velocity = Vector2(0, 0)
		emit_signal("objective_reached")
		objective_event = null
	else:
		var direction = objective_event.global_position - global_position
		velocity = direction.normalized() * speed
		global_position += velocity * delta

signal objective_reached
