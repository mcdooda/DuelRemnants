extends Evolution

func enter_map_action():
	var players = get_tree().get_nodes_in_group("player_characters")
	for player in players:
		player.heal(player.max_life * 30/100)
