extends Control
class_name HotBar

const AMOUT_SLOTS = 4

@onready var slots := $MarginContainer/VBoxContainer/Panel/HBoxContainer.get_children()

func _ready():
	
	PlayerInventore.inventory_changed.connect(update_hotbar)
	update_hotbar()

func update_hotbar():
	#print("test inv")
	# Если слотов еще нет, ничего не делаем
	if slots.is_empty():
		return

	for i in slots.size():
		if i < PlayerInventore.inventore.size():
			slots[i].set_item(PlayerInventore.inventore[i])
		else:
			slots[i].clear_item()
