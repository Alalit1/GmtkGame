class_name FireballEffect
extends ItemEffect

@export var charges: int = 10


func apply(user: Node) -> void:
	if charges <= 0:
		return

	charges -= 1

	# Створення та запуск вогняної кулі
	if user.has_method("cast_fireball"):
		user.cast_fireball()
