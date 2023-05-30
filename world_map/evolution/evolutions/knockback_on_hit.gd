extends Evolution

@export var explosion: PackedScene
@export var num_hit := 5
var hit_counter := 0

func selected(players: Array[PlayerCharacter]):
	for player in players:
		player.connect("hurt", hit)

func hit(player):
	hit_counter += 1
	if hit_counter >= num_hit:
		hit_counter = 0
		var explosion_instance = explosion.instantiate()
		explosion_instance.z_index = -1
		explosion_instance.global_position = player.global_position#d + player.sprite.position
		get_tree().root.add_child(explosion_instance)
