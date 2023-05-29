extends Evolution

var timers = {}
var fx = {}
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

func add_fx(player):
	var fx_instance = particle_effect.instantiate()
	fx_instance.z_index = -1
	fx_instance.position = player.sprite.position
	fx[player] = fx_instance
	player.add_child(fx_instance)

func healed(player):
	var timer = timers[player]
	if timer.is_stopped():
		player.add_stats(stats)
		add_fx(player)
	timer.start()

func reset_stats(player):
	player.remove_stats(stats)
	fx[player].queue_free()
