extends Control

class_name ItemCard

var choice

@onready var name_label = get_node("Panel/VBoxContainer/NameLabel")
@onready var level_label = get_node("Panel/VBoxContainer/LevelLabel")
@onready var description_label = get_node("Panel/VBoxContainer/DescriptionLabel")
@onready var focus_label = get_node("Panel/VBoxContainer/FocusLabel")
@onready var animated_sprite: AnimatedSprite2D = get_node("Panel/VBoxContainer/Control/AnimatedSprite2D")

func set_item(item_ref, delay: float):
	$AnimationPlayer.start_animation(delay)
	choice = item_ref
	name_label.text = choice.card_name
	if "current_level" in choice:
		level_label.text = "Level " + str(choice.current_level)
	else:
		level_label.visible = false
	description_label.text = choice.modifiers.description
	var animation_resource = AbilityUtils.find_item_animation(choice)
	if animation_resource:
		var icone_sprite_frame: SpriteFrames = ResourceLoader.load(animation_resource)
		animated_sprite.set_sprite_frames(icone_sprite_frame)
		animated_sprite.play("default")

func _on_gui_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_X:
			GlobalUi.emit_signal("item_selected", choice)
	elif event is InputEventMouseButton:
		GlobalUi.emit_signal("item_selected", choice)

func _on_focus_entered():
	focus_label.show()
	pass # Replace with function body.

func _on_focus_exited():
	focus_label.hide()
	pass # Replace with function body.
