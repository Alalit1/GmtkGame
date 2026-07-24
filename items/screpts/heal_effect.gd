class_name HealEffect
extends ItemEffect

@export var heal_amount: float = 20.0


func apply(user: Node) -> void:
	if user.has_method("heal"):
		user.heal(heal_amount)
