extends Evolution

func map_entered(_map):
	var players = get_tree().get_nodes_in_group("player_characters")
	for player in players:
		player.heal(player.max_life * 30/100)
