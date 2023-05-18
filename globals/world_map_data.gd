extends Node

@onready var rng := RandomNumberGenerator.new()
var current_rng_state
var current_player_node

var map_evolutions: Array[Evolution] = []

func _ready():
	rng.randomize()
	save_state()

func add_evolution(evolution: Evolution):
	map_evolutions.append(evolution)

func save_state():
	current_rng_state = rng.state

func reset_state():
	rng.state = current_rng_state

func change_player_node(player_node):
	current_player_node = player_node
