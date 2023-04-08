extends Node

class_name Ability

@export var num_projectiles := 1
@export var pierce := 0
@export var speed := 1
@export var cooldown := 1

var timer: Timer

@export var projectile_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func init(trigger_on_cooldown):
	if trigger_on_cooldown:
		timer = Timer.new()
		timer.wait_time = cooldown
		timer.connect("timeout", trigger_ability) 
		timer.set_autostart(true)

func init_timer():
	if timer:
		add_child(timer)

func trigger_ability():
	pass
