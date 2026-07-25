class_name HealthPotion
extends BaseItem

var uses
var max_uses
var heal_amout


func _ready() -> void:
	max_uses = item_data.max_uses
	heal_amout = item_data.amout_heal

	

func use(player) -> void:
	if uses <= 0:
		return
		
	player.heal(heal_amout)
	uses -= 1

	if uses <= 0:
		queue_free()
