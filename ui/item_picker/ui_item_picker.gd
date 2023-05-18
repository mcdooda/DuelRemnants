extends Control

var player_ref: Node2D
@onready var item1 = get_node("Control/Item1")
@onready var item2 = get_node("Control/Item2")
@onready var item3 = get_node("Control/Item3")

func _ready():
	GlobalExperience.connect("level_changed", on_level_changed)
	GlobalUi.connect("item_selected", on_item_selected)

func assign_players():
	var players = get_tree().get_nodes_in_group("player_characters")
	player_ref = players[0]

func instantiate_item(item_path: String, level: int):
	var resource = ResourceLoader.load(item_path)
	var instance = resource.instantiate()
	instance.init(true, level)
	return instance

func load_item(item_path: String, item_ui, delay: float):
	if not player_ref:
		assign_players()
	var player_ability = player_ref.inventory.maybe_get_ability(item_path)
	if player_ability != null:
		var item_instance = instantiate_item(item_path, player_ability.current_level + 1)
		item_ui.set_item(item_instance, delay)
	else:
		var item_instance = instantiate_item(item_path, 0)
		item_ui.set_item(item_instance, delay)

func on_level_changed():
	var picked_items: Array[String] = ItemSelector.pick_random_items(3)
	load_item(picked_items[0], item1, 0.0)
	load_item(picked_items[1], item2, 0.03)
	load_item(picked_items[2], item3, 0.06)
	show()
	item1.grab_focus()
	get_tree().paused = true
	pass

func on_item_selected(item):
	if not player_ref:
		assign_players()
	player_ref.inventory.add_instantiated_item(item)
	hide()
	get_tree().paused = false
