extends AnimatedSprite2D

class_name MapEvent

const margin = 10

var children: Array = []
enum EventType {START, BOSS, MOB, ELITE, SHOP, TREASURE, RANDOM, WEAPON}
var type := EventType.MOB

var area_scene : PackedScene
var area: Node2D
@onready var event_label = get_node("EventNamePanel/PanelContainer/PanelContainer/Label")
@onready var event_label_background: NinePatchRect = get_node("EventNamePanel/PanelContainer/NinePatchRect")
@export var elite_background_texture: Resource


func event_type_string():
	return EventType.keys()[type]

func add_child_event(child):
	if !children.has(child):
		children.append(child)
		
func load_area():
	if area:
		area.queue_free()
	var random_scene = SceneUtils.find_random_file_with_extension_from_path("res://world_map/map_event/areas/" + event_type_string(), "tscn")
	if random_scene:
		area_scene = ResourceLoader.load(random_scene)
		area = area_scene.instantiate()
		area.show_behind_parent = true
		add_child(area)

func load_animation():
	var path = scene_file_path.get_base_dir() + "/icons/" + event_type_string()
	var animation_resource = SceneUtils.find_file_with_extension_from_path(path, "tres")
	var icone_sprite_frame: SpriteFrames = ResourceLoader.load(animation_resource)
	set_sprite_frames(icone_sprite_frame)
	play("default")

func randomize_type(_weight: int):
	var rng = RandomNumberGenerator.new()
	set_type(rng.randi_range(EventType.MOB, EventType.WEAPON) as EventType)

func set_type(event_type: EventType):
	type = event_type
	if type == EventType.ELITE:
		event_label_background.texture = elite_background_texture
	load_animation()
	load_area()
	event_label.text = event_type_string().capitalize() 

func _draw():
	if type == EventType.START:
		draw_circle(Vector2.ZERO, 4, Color.WHITE_SMOKE)
	
	for child in children:
		var line = child.position - position
		var normal = line.normalized()
		line -= margin * normal
		var color = Color.GRAY
		draw_line(normal * margin, line, color, 2)
