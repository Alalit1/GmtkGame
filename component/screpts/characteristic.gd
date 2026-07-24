class_name Characteristic
extends Node


var health: float
var damage: float
var stamina : float
var speed : float
var speed_up : float
var vision_area : float

var texture : Texture2D

func setup(data: Resource):
	health = data.health
	damage = data.damage
	stamina = data.stamina
	vision_area = data.vision_area
	speed = data.speed
	speed_up = data.speed_up
	texture = data.texture
	#damage = data.damage
