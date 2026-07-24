class_name Sensors
extends Node

@onready var vision: Area2D = $VisionArea

var target: Node2D = null
var can_see_target := false


func _ready():
	vision.body_entered.connect(_on_body_entered)
	vision.body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node2D):
	if body.is_in_group("player"):
		target = body
		can_see_target = true


func _on_body_exited(body: Node2D):
	if body == target:
		target = null
		can_see_target = false
"""
var found_list: Array[Node2D] = []

signal found(body: Node2D)
signal lost(body: Node2D)


func _on_vision_area_body_exited(body: Player) -> void:
	print(body)
	if found_list.has(body):
		found_list.erase(body)
		emit_signal("lost", body)


func _on_vision_area_body_entered(body: Player) -> void:
	print(body)
	if not found_list.has(body):
		found_list.append(body)
		found.emit(body)
		print(body)
"""
