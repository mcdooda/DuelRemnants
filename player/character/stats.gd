extends Node

class_name Stats

@export var damage := 0
@export var knockback := 0
@export var cooldown := 0
@export var cooldown_percent := 0
@export var movement_speed := 0
@export var num_projectiles := 0
@export var life := 0
@export var max_life := 0

@export var description : String

func add(other: Stats):
	damage += other.damage
	knockback += other.knockback
	cooldown += other.cooldown
	cooldown_percent += other.cooldown_percent
	movement_speed += other.movement_speed
	num_projectiles += other.num_projectiles
	max_life += other.max_life
	life += other.life
	if life > max_life:
		life = max_life
	# overwrite the description
	description = other.description
