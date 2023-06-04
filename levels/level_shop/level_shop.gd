extends Level

@onready var evolution_picker = get_node("CanvasLayer/EvolutionPicker")
@onready var item_picker = get_node("CanvasLayer/ScreenUI/ItemPicker")

@export var item_price := 3
# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	GlobalUi.disconnect("item_selected", item_picker.on_item_selected)
	get_node("CanvasLayer/ScreenUI").remove_child(item_picker)
	$CanvasLayer.remove_child(evolution_picker)
	get_node("CanvasLayer/ScreenUI/ObjectiveLabel").text = "Shop"
	$ShopKeeper.connect("shop_entered", shop_entered)
	$ShopKeeper.set_text(str(item_price) + " coins")
	GlobalUi.connect("item_selected", on_evolution_selected)

func has_enough_money():
	return GlobalPlayer.total_money >= item_price

func show_evolutions():
	get_tree().paused = true
	$CanvasLayer.add_child(evolution_picker)
	evolution_picker.focus_first_item()

func say_something_angrily():
		var rng := RandomNumberGenerator.new()
		var choice = rng.randi_range(0, 3) 
		if choice == 0:
			$ShopKeeper.set_angry_text("...")
		elif choice == 1:
			$ShopKeeper.set_angry_text("I won't give you anything")
		else:
			$ShopKeeper.set_angry_text("Get out")

func shop_entered():
	if has_enough_money():
		show_evolutions()
	else:
		say_something_angrily()

func on_evolution_selected(evolution: Node):
	WorldMapData.add_evolution(evolution)
	evolution.select()
	GlobalPlayer.total_money -= item_price
