class_name StatusEffectComponent
extends Node

var effects: Array[StatusEffect] = []


func add_effect(effect: StatusEffect) -> void:
	effects.append(effect)


func remove_effect(effect: StatusEffect) -> void:
	effects.erase(effect)


func _process(delta: float) -> void:
	for effect in effects:
		effect.duration -= delta

		if effect.duration <= 0:
			remove_effect(effect)
"""
unc _on_remainder_timer_timeout() -> void:
	G.time -= 0.05
	if stamina < max_stamina:
		stamina += 0.25

		
	if G.time == 500:

		can_dash = false
		max_hp = 90
		hp = hp * 90 / 100
		max_stamina = 95
		stamina = stamina * 95 / 100

	elif G.time == 400:

		can_combo = false
		max_hp = 80
		hp = hp * 80 / 100
		max_stamina = 90
		stamina = stamina * 90 / 100

	elif G.time == 300:

		can_charge = false
		max_hp = 70
		hp = hp * 70 / 100
		max_stamina = 85
		stamina = stamina * 85 / 100

	elif G.time == 200:

		max_hp = 60
		hp = hp * 60 / 100
		max_stamina = 80
		stamina = stamina * 80 / 100
		speed = 90

	elif G.time == 100:

		max_hp = 50
		hp = hp * 50 / 100
		max_stamina = 75
		stamina = stamina * 75 / 100
		speed = 80
	
"""
