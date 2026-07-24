extends Node2D

var enemys_count = ceili(float(g.room_finish) / 2)
var spawn_data = {}

func _ready() -> void:
	pass # Replace with function body.

func preparation(pos):
	spawn_data[pos] = enemys_count

func spawn(pos):
	spawn_data[pos] -= 1
	
