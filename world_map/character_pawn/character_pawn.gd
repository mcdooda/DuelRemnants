extends CharacterBody2D

var objective_event: MapEvent
var moving := false

@export var speed := 100

func move_to_event(event: MapEvent):
	objective_event = event
	pass

func is_moving():
	return moving

func _physics_process(delta):
	if objective_event == null:
		return
	if global_position.distance_squared_to(objective_event.global_position) < 9:
		moving = false
		emit_signal("objective_reached")
	else:
		moving = true
		var direction = objective_event.global_position - global_position
		velocity = direction.normalized() * speed
		global_position += velocity * delta

signal objective_reached
