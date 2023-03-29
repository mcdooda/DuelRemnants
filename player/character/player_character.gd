extends CharacterBody2D

@export var speed = 200
@export var direction = Vector2(1, 0)

@export var ability : PackedScene

@export var playing_attack_animation = false
@export var attack_animation_frame = 13

func _ready():
	$Timer.connect("timeout", start_attack)
	$Sprite.connect("animation_looped", attack_finished)
	#$Sprite.connect("frame_changed", frame_changed)

	$Inventory.add_item(ability)
	
func start_attack():
	$Sprite.play("attack2")
	playing_attack_animation = true
	
func attack_finished():
	playing_attack_animation = false
	
func _physics_process(delta):
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	if input_direction.x != 0:
		direction.x = sign(input_direction.x)
		
	velocity = input_direction * speed
	global_position += velocity * delta

func _process(_delta):
	pass

