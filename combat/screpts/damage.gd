class_name Damage
extends RefCounted


func apply_damage(target, data: DamageData) -> void:
	if target.has_method("take_damage"):
		target.take_damage(data.amount)
