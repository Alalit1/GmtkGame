extends Node2D

var enemys_count = ceili(float(G.room_finish) / 2)
var spawn_data = {}
var enemys_array = [preload("res://entities/enemy/screns/skeletron.tscn")]

func _ready() -> void:
	G.connect("enemy_dead", Callable(self, "spawn"))
	G.connect("start_spawn", Callable(self, "first_spawn"))
	G.connect("boss_cast", Callable(self, "spawn_all"))

func preparation(pos):
	spawn_data[pos] = enemys_count
	if spawn_data.size() == 4 and not G.boss:
		first_spawn()

func spawn_all():
	for i in spawn_data:
		var enemy_load = enemys_array.pick_random()
		var enemy = enemy_load.instantiate()
		get_parent().add_child(enemy)
		enemy.position = i

func spawn(pos):
	if spawn_data[pos] > 0:
		var enemy_load = enemys_array.pick_random()
		var enemy = enemy_load.instantiate()
		get_parent().add_child(enemy)
		enemy.position = pos
		spawn_data[pos] -= 1
	var spawners_count = 0
	for spawners in spawn_data.values():
		if spawners == 0:
			spawners_count += 1
	if spawners_count == 4:
		G.emit_signal("enemys_end")

func first_spawn():
	for i in spawn_data:
		var enemy_load = enemys_array.pick_random()
		var enemy = enemy_load.instantiate()
		get_parent().add_child(enemy)
		enemy.position = i
		spawn_data[i] -= 1
