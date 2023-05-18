extends Node

var rng = RandomNumberGenerator.new()

var abilities_paths: PackedStringArray
var evolution_paths: PackedStringArray

func _ready():
	abilities_paths = SceneUtils.find_abilities_paths()
	evolution_paths = SceneUtils.find_evolution_paths()

func get_random_items_from_inventory(player_ref, max_value):
	var num_items = rng.randi_range(1, max_value)
	var items: Array[PackedScene] = []
	for i in num_items:
		var item = player_ref.inventory.random_item()
		var maybe_item_scene = AbilityUtils.find_item_scene(item)
		if maybe_item_scene:
			items.push_back(ResourceLoader.load(maybe_item_scene))
	return items

func pick_random(container_paths, num_items: int):
	var picked_items: Array[String] = []
	for i in num_items:
		var random_indice = rng.randi_range(0, container_paths.size() - 1)
		picked_items.append(container_paths[random_indice])
	return picked_items

func pick_random_items(num_items: int):
	return pick_random(abilities_paths, num_items)

func pick_random_evolution(num_evolutions: int):
	return pick_random(evolution_paths, num_evolutions)
