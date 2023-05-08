extends Control

@export var popup_scene: PackedScene
@export var objective_text: String

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().connect("size_changed", compute_size)
	size = get_viewport().get_visible_rect().size
	$ExperienceBar.compute_size()
	GlobalUi.connect("item_leveled_up", popup_item_description)

func compute_size():
	size = get_viewport().get_visible_rect().size
	$ExperienceBar.compute_size()

func popup_item_description(level, modifiers):
	var popup = popup_scene.instantiate()
	add_child(popup)
	popup.set_text(level, modifiers.description)
