extends CharacterBody2D

@export var speed = 120

@onready var target = get_node("/root/level_1/PlayerCharacter/Collision")
var is_alive = true

@onready var sprite_material = $Sprite.material

func _ready():
	$Sprite.connect("animation_looped", animation_looped)
	
func animation_looped():
	if $Sprite.animation == "death":
		get_parent().remove_child(self)
		
func kill():
	$Sprite.play("death")
	is_alive = false
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1, 1, 1, 0), 0.5)
	
func hit():
	sprite_material.set_shader_parameter("flash_active", true)

	#var tween = create_tween()
	#tween.tween_property(self, "modulate", Color(3, 3, 3, 1), 0.3)

func _physics_process(_delta):
	if not is_alive:
		return
	
	var target_position = target.global_position
	var self_position = global_position
	var direction = target_position - self_position
	velocity = direction.normalized() * speed
	move_and_slide()
