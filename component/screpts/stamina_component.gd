extends Node


@export var characteristics_component : Characteristic

var max_stamina: float
var entity_type
var stamina: float

func setup():
	max_stamina = characteristics_component.stamina
	entity_type = characteristics_component.entity_type
	stamina = max_stamina


func _ready():
	
	pass

	
