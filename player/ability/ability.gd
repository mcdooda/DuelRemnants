extends Node2D

class_name Ability

@export var card_name: String
@export var num_projectiles := 1
@export var pierce := 0
@export var speed := 1
@export var cooldown := 1
var current_level := 0

var timer: Timer
#@export var item: Resource
@export var projectile_scene: PackedScene
var stats := Stats.new()

func init(trigger_on_cooldown, level = 0):
	current_level = level
	# each level adds to the item modifier, we have load each
	for i in current_level + 1:
		load_level_stats(i)
	if trigger_on_cooldown:
		timer = Timer.new()
		timer.wait_time = cooldown
		timer.connect("timeout", trigger_ability) 
		timer.set_autostart(true)

func init_timer():
	if timer:
		add_child(timer)

func trigger_ability():
	pass

func max_projectiles():
	var total = total_stats()
	return num_projectiles + total.num_projectiles

func total_stats():
	var total := Stats.new()
	total.add(stats)
	total.add(get_parent().stats)
	return total

func get_level_scene(path, level):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.get_basename() == "level_" + str(level):
				return path + "/" + file_name
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path: ", path)
	return null
	
func get_level_modifier(level):
	var current_path = get_script().resource_path.get_base_dir()
	return get_level_scene(current_path + "/levels", level)

func load_modifier(modifier_scene):
	var next_stats = ResourceLoader.load(modifier_scene)
	var instance = next_stats.instantiate()
	stats.add(instance)
	return instance

func load_level_stats(level: int):
	var maybe_next_level = get_level_modifier(level)
	if maybe_next_level != null:
		return load_modifier(maybe_next_level)
	return null

func level_up():
	current_level += 1
	var instance = load_level_stats(current_level)
	if instance:
		GlobalUi.emit_signal("item_leveled_up", current_level, instance)
