extends Node

class_name Modifiers

@export var damage := 0
@export var knockback := 0
@export var cooldown := 0
@export var speed := 0
@export var num_projectiles := 0
@export var description : String

func add(other: Modifiers):
	damage += other.damage
	knockback += other.knockback
	cooldown += other.cooldown
	speed += other.speed
	num_projectiles += other.num_projectiles
