extends CharacterBody2D

class_name BaseEnemy

@export var max_speed := 120
var speed = max_speed
@export var drop_item_scene: PackedScene
@export var drop_item_chance := 0.5
@export var knockback_resistance := 0.0
@export var life := 5

@onready var target = get_node("/root/level/PlayerCharacter/Collision")
var is_alive = true

@onready var sprite_material = $Sprite.material
var rng = RandomNumberGenerator.new()

var direction: Vector2
@export var acceleration = 600

func _ready():
	$FlashTimer.connect("timeout", reset_flash)

func drop_item():
	$Collision.disabled = true
	var dropped_item = drop_item_scene.instantiate()
	dropped_item.global_position = global_position
	get_tree().root.add_child(dropped_item)

func maybe_drop_item():
	if rng.randf_range(0, 1) <= drop_item_chance:
		call_deferred("drop_item")

func kill(instant = false):
	if not is_alive:
		return
	is_alive = false
	emit_signal("enemy_dies")
	if not instant:
		maybe_drop_item()
		$Sprite.play("death")
	else:
		get_parent().remove_child(self)

func hit(knockback, damage):
	speed -= knockback * (1.0 - knockback_resistance)
	life -= damage
	flash()
	if life <= 0:
		kill()

func flash():
	sprite_material.set_shader_parameter("flash_active", true)
	$FlashTimer.start()
	
func reset_flash():
	sprite_material.set_shader_parameter("flash_active", false)

func handle_direction():
	var target_position = target.global_position
	var self_position = global_position
	direction = target_position - self_position

func _physics_process(delta):
	if not is_alive:
		return
	handle_direction()
	speed = min(speed + delta * acceleration, max_speed)
	velocity = direction.normalized() * speed
	move_and_slide()
	handle_collision_with_player()

func handle_collision_with_player():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("player"):
			collision.get_collider().hit()

func _on_sprite_animation_finished():
	if $Sprite.animation == "death":
		get_parent().remove_child(self)

signal enemy_dies
