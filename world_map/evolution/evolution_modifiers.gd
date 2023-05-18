extends Node

class_name EvolutionModifiers

@export var damage := 0
@export var knockback := 0
@export var cooldown := 0
@export var cooldown_percent := 0
@export var movement_speed := 0
@export var num_projectiles := 0
@export var life := 0
@export var description : String

func add(other: Modifiers):
	damage += other.damage
	knockback += other.knockback
	cooldown += other.cooldown
	cooldown_percent += other.cooldown_percent
	movement_speed += other.movement_speed
	num_projectiles += other.num_projectile
	life += other.life
	description = other.description
