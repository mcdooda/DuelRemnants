extends Control

@onready var item1 = get_node("Control/Item1")
@onready var item2 = get_node("Control/Item2")
@onready var item3 = get_node("Control/Item3")

func _ready():
	var evolutions: Array[String] = ItemSelector.pick_random_evolution(3)
	var instance = ResourceLoader.load(evolutions[0]).instantiate()
	add_child(instance)
	item1.set_item(instance, 0.0)
	var instance2 = ResourceLoader.load(evolutions[1]).instantiate()
	add_child(instance2)
	item2.set_item(instance2, 0.1)
	var instance3 = ResourceLoader.load(evolutions[2]).instantiate()
	add_child(instance3)
	item3.set_item(instance3, 0.2)
	
	item1.grab_focus()

func focus_first_item():
	item1.grab_focus()
