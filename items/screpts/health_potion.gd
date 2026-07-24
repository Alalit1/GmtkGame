class_name HealthPotion
extends BaseItem

@export var heal_amount: int = 20


func _on_use() -> void:
	var player = get_tree().get_first_node_in_group("player")

	if player:
		player.heal(heal_amount)
		
func pick_up(player) -> void:
	
	if player.inventory.add_item(item_data):
		queue_free()
