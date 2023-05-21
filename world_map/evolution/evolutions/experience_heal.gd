extends Evolution

var players_ref

func selected(players: Array[PlayerCharacter]):
	GlobalExperience.connect("experience_changed", experience_changed)
	players_ref = players

func experience_changed():
	for player in players_ref:
		player.heal(1)
