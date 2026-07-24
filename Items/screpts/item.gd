class_name Item
extends Node2D

@export var item_name: String = ""
@export var max_uses: int = 1
@export var uses: int = 1

func use() -> void:
	if uses <= 0:
		return

	_on_use()

	uses -= 1

	if uses <= 0:
		queue_free()


func _on_use() -> void:
	pass
	
#func pick_up(player) -> void:
	
	#if player.inventory.add_item(item_data):
	#	queue_free()
