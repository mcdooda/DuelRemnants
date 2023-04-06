extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	max_value = get_parent().max_life
	value = get_parent().life
	get_parent().connect("life_changed", on_life_changed)

func on_life_changed(life):
	value = life
