extends Control

@onready var player_ref = get_node("/root/level_1/PlayerCharacter")

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	GlobalExperience.connect("level_changed", on_level_changed)
	GlobalUi.connect("item_selected", on_item_selected)

func load_item(item_path: String, item_ui):
	var player_ability = player_ref.inventory.maybe_get_ability(item_path)
	if player_ability != null:
		item_ui.set_item(item_path, player_ability.current_level + 1)
	else:
		item_ui.set_item(item_path, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_level_changed():
	var picked_items: Array[String] = ItemSelector.pick_random_items(3)
	load_item(picked_items[0], $Item1)
	load_item(picked_items[1], $Item2)
	load_item(picked_items[2], $Item3)
	show()
	$Item1.grab_focus()
	get_tree().paused = true
	pass

func on_item_selected(item):
	player_ref.inventory.add_instantiated_item(item)
	hide()
	get_tree().paused = false
