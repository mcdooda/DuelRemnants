extends CharacterBody2D

@export var speed = 400

func _physics_process(delta):
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * speed
	global_position += velocity * delta

func _process(_delta):
	pass

