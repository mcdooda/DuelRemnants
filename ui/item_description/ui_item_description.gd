extends Control

var ability: Ability

@onready var name_label = get_node("Panel/VBoxContainer/NameLabel")
@onready var level_label = get_node("Panel/VBoxContainer/LevelLabel")
@onready var description_label = get_node("Panel/VBoxContainer/DescriptionLabel")
@onready var focus_label = get_node("Panel/VBoxContainer/FocusLabel")
@onready var animated_sprite: AnimatedSprite2D = get_node("Panel/VBoxContainer/Control/AnimatedSprite2D")

func set_item(ability_path, level):
	var ability_resource = ResourceLoader.load(ability_path)
	ability = ability_resource.instantiate()
	ability.init(true, level)
	name_label.text = ability.ability_name
	level_label.text = "Level " + str(ability.current_level)
	description_label.text = ability.modifiers.description
	var icone_sprite_frame: SpriteFrames = ResourceLoader.load(AbilityUtils.find_item_animation(ability))
	animated_sprite.set_sprite_frames(icone_sprite_frame)
	animated_sprite.play("default")

func _on_gui_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_X:
			GlobalUi.emit_signal("item_selected", ability)
	elif event is InputEventMouseButton:
		GlobalUi.emit_signal("item_selected", ability)

func _on_focus_entered():
	focus_label.show()
	pass # Replace with function body.

func _on_focus_exited():
	focus_label.hide()
	pass # Replace with function body.
