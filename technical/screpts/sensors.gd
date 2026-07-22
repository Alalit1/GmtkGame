extends Node

var found_list: Array[Node2D] = []

signal found(body: Node2D)
signal lost(body: Node2D)

func _on_body_entered(body: Node2D) -> void:
	if not found_list.has(body):
		found_list.append(body)
		found.emit(body)

func _on_body_exited(body: Node2D) -> void:
	if found_list.has(body):
		found_list.erase(body)
		emit_signal("lost", body)
