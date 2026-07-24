class_name DistributedDamage
extends Node


func apply(damage_data: DamageData, target) -> void:
	var tick_count := int(
		damage_data.duration /
		damage_data.tick_interval
	)

	if tick_count <= 0:
		return

	var damage_per_tick := (
		damage_data.base_damage /
		tick_count
	)

	for i in range(tick_count):

		var tick_data := DamageData.new()

		tick_data.base_damage = damage_per_tick
		tick_data.damage_type = damage_data.damage_type

		var calculator := DamageCalculate.new()

		var final_damage := calculator.calculate(
			tick_data,
			target
		)

		target.take_damage(final_damage)

		await get_tree().create_timer(
			damage_data.tick_interval
		).timeout

	queue_free()
