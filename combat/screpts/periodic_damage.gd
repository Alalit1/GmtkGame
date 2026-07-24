class_name PeriodicDamage
extends DamageEffect


func apply(damage_data: DamageData, target) -> void:
	_apply_periodic(damage_data, target)


func _apply_periodic(
	damage_data: DamageData,
	target
) -> void:

	var elapsed_time := 0.0

	while elapsed_time < damage_data.duration:
		var calculator := DamageCalculate.new()

		var final_damage := calculator.calculate(
			damage_data,
			target
		)

		target.take_damage(final_damage)

		await target.get_tree().create_timer(
			damage_data.tick_interval
		).timeout

		elapsed_time += damage_data.tick_interval
