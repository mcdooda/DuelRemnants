extends Evolution

var timers = {}

func init_timer():
	var timer := Timer.new()
	timer.wait_time = 2
	timer.one_shot = true
	add_child(timer)
	return timer

func selected(players: Array[PlayerCharacter]):
	for player in players:
		player.connect("healed", healed)
		timers[player] = init_timer()

func healed(player):
	player.add_stats(stats)
	timers[player].start()
	timers[player].connect("timeout", func(): reset_stats(player))

func reset_stats(player):
	player.remove_stats(stats)
