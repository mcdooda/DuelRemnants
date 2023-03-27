extends Node

class_name Ability

@export var num_projectiles := 1
@export var pierce := 0
@export var speed := 1
@export var cooldown := 1

var player_ref
var timer: Timer

var root: Node

@export var Emitter: Resource
@export var projectile_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func init(player):
	print ("Init item")
	#do your init
	player_ref = player
	timer = Timer.new()
	timer.wait_time = cooldown
	timer.connect("timeout", trigger_ability) 
	timer.set_autostart(true)
	print("Starting timer...")

func init_timer():
	add_child(timer)

func trigger_ability():
	print ("Trigger ability")
	Emitter.emit(projectile_scene, num_projectiles, player_ref, root)
