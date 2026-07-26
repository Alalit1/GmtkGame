class_name Damage
extends RefCounted


func apply_damage(data: DamageData,target) -> void:
	if target.has_method("take_damage"):
		print("damagetest")
		target.take_damage(data.amount)
