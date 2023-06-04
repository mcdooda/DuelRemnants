extends card_selector

func select_cards(number: int):
	return ItemSelector.pick_random_evolution(number)
