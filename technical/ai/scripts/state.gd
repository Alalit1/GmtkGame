class_name State
extends RefCounted


var owner: CharacterBody2D
var action: Action


func _init(_owner: CharacterBody2D) -> void:
	owner = _owner


func set_action(_action: Action) -> void:
	action = _action


func enter() -> void:
	pass


func exit() -> void:
	pass


func update(_delta: float) -> void:
	pass
