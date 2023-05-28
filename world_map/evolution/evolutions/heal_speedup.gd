extends Evolution

var timers = {}
@export var particle_effect: PackedScene
@export var duration := 3

func init_timer():
	var timer := Timer.new()
	timer.wait_time = duration
	timer.one_shot = true
	add_child(timer)
	return timer

func selected(players: Array[PlayerCharacter]):
	for player in players:
		player.connect("healed", healed)
		timers[player] = init_timer()
		timers[player].connect("timeout", func(): reset_stats(player))

func healed(player):
	var timer = timers[player]
	if timer.is_stopped():
		player.add_stats(stats)
		var instance = particle_effect.instantiate()
		player.add_child(instance)
	timer.start()

func reset_stats(player):
	player.remove_stats(stats)
