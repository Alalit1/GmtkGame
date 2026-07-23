extends Area2D
class_name AreaInteraction

var list_item := []


func _on_body_entered(body: Node2D) -> void:
	if body in list_item:
		list_item.erase(body)


func _on_body_exited(body: Node2D) -> void:
	list_item.erase(body)
