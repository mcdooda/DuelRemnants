extends Control

class_name ItemCard

var choice

@onready var name_label = get_node("AnimatedControl/MarginContainer/Panel/VBoxContainer/NameLabel")
@onready var level_label = get_node("AnimatedControl/MarginContainer/Panel/VBoxContainer/LevelLabel")
@onready var description_label = get_node("AnimatedControl/MarginContainer/Panel/VBoxContainer/DescriptionLabel")
@onready var animated_sprite: AnimatedSprite2D = get_node("AnimatedControl/MarginContainer/Panel/VBoxContainer/Control/AnimatedSprite2D")
@onready var animation_player = get_node("AnimatedControl/AnimationPlayer")

func set_item(item_ref):
	choice = item_ref
	name_label.text = choice.card_name
	if "current_level" in choice:
		level_label.text = "Level " + str(choice.current_level)
	else:
		level_label.visible = false
	description_label.text = choice.stats.description
	var animation_resource = AbilityUtils.find_item_animation(choice)
	if animation_resource:
		var icone_sprite_frame: SpriteFrames = ResourceLoader.load(animation_resource)
		animated_sprite.set_sprite_frames(icone_sprite_frame)
		animated_sprite.play("default")

func _on_gui_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE:
			select_item()
	elif event is InputEventMouseButton:
		select_item()

func select_item():
	GlobalUi.emit_signal("item_selected", choice)

func _on_focus_entered():
	animation_player.play("focused")
	pass # Replace with function body.

func _on_focus_exited():
	animation_player.play("RESET")
	pass # Replace with function body.
