extends CharacterBody2D

@export var speed = 200
@export var direction = Vector2(1, 0)

@export var starting_ability : PackedScene

@export var playing_attack_animation = false
@export var attack_animation_frame = 13

@export var max_life = 20
var life = max_life
var invincible = false

func _ready():
	$Timer.connect("timeout", start_attack)
	$InvincibilityTimer.connect("timeout", reset_invincibility)
	$Sprite.connect("animation_looped", attack_finished)
	$Inventory.add_item(starting_ability)
	
func start_attack():
	$Sprite.play("attack2")
	playing_attack_animation = true
	
func attack_finished():
	playing_attack_animation = false
	
func _physics_process(delta):
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	if input_direction.x != 0 or input_direction.y != 0:
		direction = input_direction
	velocity = input_direction * speed
	global_position += velocity * delta

func hit():
	if not invincible:
		invincible = true
		life -= 1
		emit_signal("life_changed", life)
		$InvincibilityTimer.start()

func _process(_delta):
	pass
	
func reset_invincibility():
	invincible = false

signal life_changed
