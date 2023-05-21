extends Evolution

func selected(players: Array[PlayerCharacter]):
	for player in players:
		player.add_stats(stats)
