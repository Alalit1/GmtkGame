class_name CooldownComponent
extends Node

signal cooldown_finished(name: String)

var cooldowns: Dictionary = {}


func start(name: String, time: float) -> void:
	cooldowns[name] = time


func is_ready(name: String) -> bool:
	return not cooldowns.has(name)


func get_remaining(name: String) -> float:
	return cooldowns.get(name, 0.0)


func _process(delta: float) -> void:
	for name in cooldowns.keys():
		cooldowns[name] -= delta

		if cooldowns[name] <= 0.0:
			cooldowns.erase(name)
			cooldown_finished.emit(name)
