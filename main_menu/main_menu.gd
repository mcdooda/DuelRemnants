extends MarginContainer

@onready var continue_label = get_node("HBoxContainer/VBoxContainer/VBoxContainer2/Continue")
@onready var new_game_label = get_node("HBoxContainer/VBoxContainer/VBoxContainer2/NewGame")
@onready var quit_label = get_node("HBoxContainer/VBoxContainer/VBoxContainer2/Quit")

func _ready():
	continue_label.grab_focus()

func _on_quit_pressed():
	get_tree().quit()

func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://world_map/world_map.tscn")

func _on_continue_pressed():
	pass # Replace with function body.
