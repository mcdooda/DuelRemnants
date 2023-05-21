extends CharacterBody2D

class_name PlayerCharacter

@export var direction := Vector2(1, 0)

@export var heal_animation: PackedScene
@export var starting_ability : PackedScene
var starting_ability_ref : Ability
@export var attack_frame := 12

@export var playing_attack_animation = false
@export var attack_animation_frame = 13

var invincible = false
@onready var muzzle = $Muzzle
@onready var inventory = $Inventory
@onready var stats = $Statistics

func _ready():
	$Timer.connect("timeout", start_attack)
	$InvincibilityTimer.connect("timeout", reset_invincibility)
	$Sprite.connect("animation_looped", attack_finished)
	$Sprite.connect("frame_changed", frame_changed)
	init_health_bar()
	starting_ability_ref = $Inventory.add_item(starting_ability, false)

func init_health_bar():
	$HealthBar.value = stats.life
	$HealthBar.max_value = stats.max_life
	connect("life_changed", $HealthBar.on_life_changed)

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
	direction = input_direction
	direction.x = -1 if $Sprite.is_flipped_h() else 1
	velocity = input_direction * stats.movement_speed
	global_position += velocity * delta

func change_life(delta: int):
	if stats.life + delta > 0 and stats.life + delta < stats.max_life:
		stats.life += delta
		emit_signal("life_changed", stats.life)

func hit():
	if not invincible:
		invincible = true
		$InvincibilityTimer.start()
		change_life(-1)

func play_heal_animation():
	var animation = heal_animation.instantiate()
	add_child(animation)

func heal(delta):
	change_life(delta)
	play_heal_animation()

func _process(_delta):
	var v := get_viewport()
	v.canvas_transform = Transform2D(0.0, -Vector2i(global_position) + Vector2i(v.get_visible_rect().size) / 2)

func reset_invincibility():
	invincible = false

func add_stats(other: Stats):
	var previous_life = stats.life
	stats.add(other)
	if previous_life < stats.life:
		play_heal_animation()
		emit_signal("life_changed", stats.life)

signal life_changed
