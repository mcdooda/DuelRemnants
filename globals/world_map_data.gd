extends Node

@onready var rng := RandomNumberGenerator.new()
var current_rng_state
var current_player_node
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	save_state()

func save_state():
	current_rng_state = rng.state

func reset_state():
	rng.state = current_rng_state

func change_player_node(player_node):
	current_player_node = player_node
