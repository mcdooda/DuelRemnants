extends CharacterBody2D

class_name BaseEnemy

@export var max_speed = 120
var speed = max_speed
@export var drop_item_scene: PackedScene
@export var drop_item_chance = 0.5
@export var life = 5

@onready var target = get_node("/root/level_1/PlayerCharacter/Collision")
var is_alive = true

@onready var sprite_material = $Sprite.material
var rng = RandomNumberGenerator.new()

func _ready():
	$FlashTimer.connect("timeout", reset_flash)


func drop_item():
	var dropped_item = drop_item_scene.instantiate()
	dropped_item.global_position = global_position
	get_tree().root.add_child(dropped_item)

func maybe_drop_item():
	if rng.randf_range(0, 1) <= drop_item_chance:
		call_deferred("drop_item")

func kill():
	if not is_alive:
		return
	$Sprite.play("death")
	is_alive = false
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1, 1, 1, 0), 0.5)
	maybe_drop_item()
	emit_signal("enemy_dies")

func hit(knockback, damage):
	speed -= knockback
	life -= damage
	if life <= 0:
		kill()
	else:
		flash()

func flash():
	sprite_material.set_shader_parameter("flash_active", true)
	$FlashTimer.start()
	
func reset_flash():
	sprite_material.set_shader_parameter("flash_active", false)

func _physics_process(_delta):
	if not is_alive:
		return
	if speed < max_speed:
		speed = min(speed + _delta * 600, max_speed)
	var target_position = target.global_position
	var self_position = global_position
	var direction = target_position - self_position
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
