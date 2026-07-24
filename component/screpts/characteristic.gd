class_name Characteristic
extends Node


var health: float
var damage: float
var speed : float
var speed_up : float

var texture : Texture2D

func setup(data: Resource):
	health = data.health
	damage = data.damage
	speed = data.speed
	speed_up = data.speed_up
	texture = data.texture
	#damage = data.damage
