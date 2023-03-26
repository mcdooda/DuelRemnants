extends CharacterBody2D

@export var speed = 120

@onready var target = get_node("/root/level_1/PlayerCharacter/Collision")

func _physics_process(_delta):
	var target_position = target.global_position
	var self_position = global_position
	var direction = target_position - self_position
	velocity = direction.normalized() * speed
	move_and_slide()

func _process(_delta):
	pass
