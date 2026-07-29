class_name Damage
extends RefCounted


func apply_damage(data: DamageData,target) -> void:
	target.take_damage(data.amount)
