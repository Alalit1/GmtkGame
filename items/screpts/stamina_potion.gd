class_name StaminaPotion
extends BaseItem


var uses
var max_uses
var stamina_amout

func _ready() -> void:
	max_uses = item_data.max_uses
	stamina_amout = item_data.stamina_amout
	

func use(player) -> void:
	if uses <= 0:
		return
		
	player.stamina(stamina_amout)
	uses -= 1

	if uses <= 0:
		queue_free()
