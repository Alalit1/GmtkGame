extends Node2D

var loot = [preload("res://Items/screens/health_potion.tscn"), preload("res://items/screens/scroll_fire_ball.tscn")]
var rng := RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	var spawn_loot = loot.pick_random()
	var object = spawn_loot.instantiate()
	object.position.x = rng.randi_range(13, 18) * 20 + 10
	object.position.y = rng.randi_range(6, 11) * 20 + 10
	add_child(object)
