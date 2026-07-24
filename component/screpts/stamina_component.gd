extends Node


@export var characteristics_component : Characteristic

@onready var MAX_stamina := characteristics_component.stamina
var health : float
func _ready():
	
	health = MAX_stamina


	
