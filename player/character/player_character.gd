extends CharacterBody2D

@export var speed = 200
@export var direction = Vector2(1, 0)

@export var heal_animation: PackedScene
@export var starting_ability : PackedScene
var starting_ability_ref : Ability
@export var attack_frame := 12

@export var playing_attack_animation = false
@export var attack_animation_frame = 13

@export var max_life = 20
var life = max_life
var invincible = false
@onready var muzzle = $Muzzle
@onready var inventory = $Inventory

func _ready():
	$Timer.connect("timeout", start_attack)
	$InvincibilityTimer.connect("timeout", reset_invincibility)
	$Sprite.connect("animation_looped", attack_finished)
	$Sprite.connect("frame_changed", frame_changed)
	starting_ability_ref = $Inventory.add_item(starting_ability, false)

func start_attack():
	$Sprite.play("attack2")
	playing_attack_animation = true

func attack_finished():
	playing_attack_animation = false

func frame_changed():
	if playing_attack_animation and $Sprite.frame == attack_frame:
		starting_ability_ref.trigger_ability()

func _physics_process(delta):
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	if input_direction.x != 0 or input_direction.y != 0:
		direction = input_direction
	velocity = input_direction * speed
	global_position += velocity * delta

func change_life(delta: int):
	if life + delta > 0 and life + delta < max_life:
		life += delta
		emit_signal("life_changed", life)

func hit():
	if not invincible:
		invincible = true
		$InvincibilityTimer.start()
		change_life(-1)

func heal(delta):
	change_life(delta)
	var animation = heal_animation.instantiate()
	add_child(animation)

func _process(_delta):
	var v := get_viewport()
	v.canvas_transform = Transform2D(0.0, -Vector2i(global_position) + Vector2i(v.get_visible_rect().size) / 2)
	
func reset_invincibility():
	invincible = false

signal life_changed
