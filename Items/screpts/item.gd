class_name Item
extends Resource

@export var item_data: ItemData


func use(user) -> bool:
	return false

func on_pickup(user) -> void:
	pass
