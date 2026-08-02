extends Node2D

@onready var camera = $Camera2D
@onready var pl = $player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera.position.x = pl.position.x
	camera.position.y = pl.position.y
	SpawnManager.spawn_enemy("goblin",Vector2(500.0,250.0))
	SpawnManager.spawn_enemy("skeleton",Vector2(250.0,250.0))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.


	#camera.global_position = pl.global_position
