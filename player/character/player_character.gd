extends CharacterBody2D

@export var speed = 200
@export var projectile_scene: PackedScene
@export var playing_attack_animation = false

func _ready():
	$Timer.connect("timeout", start_attack)
	$Sprite.connect("animation_looped", attack_finished)
	
func start_attack():
	$Sprite.play("attack2")
	playing_attack_animation = true
	
func attack_finished():
	playing_attack_animation = false
	
func _physics_process(delta):
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * speed
	global_position += velocity * delta

func _process(_delta):
	pass

