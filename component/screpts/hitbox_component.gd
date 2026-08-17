extends Area2D
class_name HitboxComponent

@export var health_component : HealthComponent



func take_damage(amount: float) -> void:
	print("HITBOX ОТРИМАВ УРОН:", amount)

	var label = preload("res://GUI/screens/amount_damage.tscn").instantiate()
	
	label.text = "-" + str(amount)
	label.global_position = self.global_position
	get_tree().current_scene.add_child(label)

	health_component.take_damage(amount)
	
	
"""func _on_area_entered(area:Area2D) -> void:
	print("seeee")
	print("Зайшла зона:", area)
	if area is not DamageZone:
		return
		
	print("HITBOX ОТРИМАВ УРОН")
	var damage_zone := area as DamageZone

	
	print("УРОН:", damage_zone.damage_data.amount)
	print("Damage:", damage_zone.damage_data.amount)
	health_component.take_damage(damage_zone.damage_data.amount)"""
