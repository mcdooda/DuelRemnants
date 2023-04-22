extends Node

var rng = RandomNumberGenerator.new()

var abilities_paths: PackedStringArray

func _ready():
	abilities_paths = SceneUtils.find_abilities_paths()

func get_random_items_from_inventory(player_ref, max_value):
	var num_items = rng.randi_range(1, max_value)
	var items: Array[PackedScene] = []
	for i in num_items:
		var item = player_ref.inventory.random_item()
		var maybe_item_scene = AbilityUtils.find_item_scene(item)
		if maybe_item_scene:
			items.push_back(ResourceLoader.load(maybe_item_scene))
	return items

func pick_random_items(num_items):
	var picked_items: Array[String] = []
	for i in num_items:
		var random_indice = rng.randi_range(0, abilities_paths.size() - 1)
		picked_items.append(abilities_paths[random_indice])
	return picked_items
