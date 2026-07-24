class_name Damage
extends RefCounted


func apply(damage_data: DamageData, target) -> void:

	match damage_data.damage_mode:

		DamageMode.Value.INSTANT:
			_apply_instant(
				damage_data,
				target
			)

		DamageMode.Value.PERIODIC:
			_apply_periodic(
				damage_data,
				target
			)

		DamageMode.Value.DISTRIBUTED:
			_apply_distributed(
				damage_data,
				target
			)


func _apply_instant(
	damage_data: DamageData,
	target
) -> void:

	var calculator := DamageCalculate.new()

	var final_damage := calculator.calculate(
		damage_data,
		target
	)

	target.take_damage(final_damage)


func _apply_periodic(
	damage_data: DamageData,
	target
) -> void:

	var effect := PeriodicDamage.new()

	target.get_tree().current_scene.add_child(effect)

	effect.apply(
		damage_data,
		target
	)


func _apply_distributed(
	damage_data: DamageData,
	target
) -> void:

	var effect := DistributedDamage.new()

	target.get_tree().current_scene.add_child(effect)

	effect.apply(
		damage_data,
		target
	)
