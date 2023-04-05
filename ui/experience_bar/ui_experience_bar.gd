extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalExperience.connect("experience_changed", on_experience_changed)
	GlobalExperience.connect("level_changed", on_level_changed)
	max_value = GlobalExperience.required_experience
	value = GlobalExperience.current_experience
	compute_size()
	$LevelLabel.text = "Level " + str(GlobalExperience.current_level)

func initialize(current, maximum):
	max_value = maximum
	value = current

func on_level_changed():
	value = min_value
	max_value = GlobalExperience.required_experience
	$LevelLabel.text = "Level " + str(GlobalExperience.current_level)

func on_experience_changed():
	value = GlobalExperience.current_experience

func compute_size():
	var parent_size = get_parent().size / 2
	size = Vector2(parent_size.x + 1, 10)
	$LevelLabel.position = Vector2(parent_size.x - 100, 0)
