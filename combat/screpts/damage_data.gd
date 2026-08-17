class_name DamageData
extends Resource

@export var amount: float = 10.0
@export var speed: float = 10.0
@export var sprite: Texture2D
@export_enum("INSTANT","PROJECTILE") var attacktype:int

@export_category("Area")
@export var position: Vector2
@export_group("Rect")
@export var size_x : float = 20.0
@export var size_y : float = 20.0
@export_group("Circle")
@export var radius : float = 20.0
