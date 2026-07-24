class_name DamageCalculate
extends RefCounted


func calculate(damage_data: DamageData, target) -> float:
	var damage := damage_data.base_damage

	match damage_data.damage_type:
		DamageType.Type.PHYSICAL:
			damage = _calculate_physical(damage, target)

		DamageType.Type.FIRE:
			damage = _calculate_fire(damage, target)


	return max(damage, 0.0)
	
func _calculate_physical(damage: float, target) -> float:
	return damage
	
func _calculate_fire(damage: float, target) -> float:

	return damage 
	
