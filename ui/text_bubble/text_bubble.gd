extends Control

@onready var label = get_node("PanelContainer/Label")

func set_text(text: String):
	label.text = text
	
func set_shacky_text(text: String):
	label.text = "[shake rate=20.0 level=5]" + text + "[/shake]"

func set_wavy_text(text: String):
	label.text = "[wave amp=50.0 freq=5.0]" + text + "[/wave]"

func set_rainbow_text(text: String):
	label.text = "[rainbow freq=1.0 sat=0.8 val=0.8]" + text + "[/rainbow]"
