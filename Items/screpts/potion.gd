class_name Potion
extends Item

@export var heal: float = 50

func can_use(user) -> bool:
	return true

func use(user) -> bool:
	user.health.heal(heal)
	return true
