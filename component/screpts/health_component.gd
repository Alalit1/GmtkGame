extends Node
class_name HealthComponent

signal daed


@export var characteristics_component : Characteristic
@onready var MAX_HEALTH := characteristics_component.health


var health : float


func _ready():
	
	health = MAX_HEALTH

func take_damage(amount: float):
	print(health,"__",amount)
	health -= amount

	if health <= 0:
		emit_signal("daed")
