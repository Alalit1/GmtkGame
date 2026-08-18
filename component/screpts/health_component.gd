extends Node
class_name HealthComponent

signal daed
signal hp_changed(new_hp)

@export var characteristics_component : Characteristic

var max_health: float
var health: float
var entity_type: int
func setup():
	max_health = characteristics_component.health
	entity_type = characteristics_component.entity_type
	health = max_health

	#print("MAX HEALTH:", max_health)
	#print("HEALTH:", health)

func take_damage(amount: float):
	#print(health,"__",amount)
	
	health -= amount
	if entity_type == 1:
		#print(health,"_=++_",amount)
		hp_changed.emit(health)

	if health <= 0.0:
		print("DAED")
		daed.emit()
