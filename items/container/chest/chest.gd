extends ItemContainer

func check_content():
	if player_ref != null and items.is_empty():
		items = ItemSelector.get_random_items_from_inventory(player_ref, 5)
