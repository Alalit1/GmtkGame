extends Area2D
class_name HitboxComponent

@export var health_component : HealthComponent

func game(attack):
	if health_component:
		health_component.gamage(attack)
