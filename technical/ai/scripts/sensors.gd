class_name Sensors
extends Node

@onready var vision: Area2D = $VisionArea

var target: Node2D = null
var vision_list = []



func _on_vision_area_body_entered(body: Node2D) -> void:
	vision_list.append(body)
	if body.is_in_group("player"):
		target = body


func _on_vision_area_body_exited(body: Node2D) -> void:
	vision_list.append(body)
