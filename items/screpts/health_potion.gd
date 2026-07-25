class_name HealthPotion
extends BaseItem

@export var heal_amount: int = 20

func pick_up(player) -> void:
	
	if player.inventory.add_item(item_data):
		queue_free()
