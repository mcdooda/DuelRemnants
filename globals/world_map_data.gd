extends Node

@onready var rng := RandomNumberGenerator.new()
var current_state

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	save_state()

func save_state():
	current_state = rng.state

func reset_state():
	rng.state = current_state
