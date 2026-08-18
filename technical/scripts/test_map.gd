extends Node2D

@onready var pl = $player

func _ready() -> void:
	var test = 10 * 90 / 100
	print(test)
	SpawnManager.spawn_enemy("goblin",Vector2(500.0,250.0))
	SpawnManager.spawn_enemy("skeleton",Vector2(100.0,250.0))
	SpawnManager.spawn_enemy("wizard",Vector2(100.0,100.0))
