extends MarginContainer
@onready var continue_label = get_node("HBoxContainer/VBoxContainer/VBoxContainer2/Continue")
@onready var new_game_label = get_node("HBoxContainer/VBoxContainer/VBoxContainer2/NewGame")
@onready var quit_label = get_node("HBoxContainer/VBoxContainer/VBoxContainer2/Quit")

# Called when the node enters the scene tree for the first time.
func _ready():
	continue_label.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
