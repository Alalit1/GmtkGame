class_name ItemEffect
extends Resource


func use_item(item: ItemData, user: Node) -> bool:
	match item.effect:
		ItemData.ItemType.HEAL:
			user.health += item.value

		ItemData.ItemType.DAMAGE:
			# ...
			pass

		ItemData.ItemType.SPEED:
			# ...
			pass

	return true
