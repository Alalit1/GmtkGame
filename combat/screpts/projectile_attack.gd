extends Node2D
class_name ProjectileAttack

#@export var damage_data: DamageData
#var target_move := Vector2(500, 300)
var speed : float
var damage: int
var direction: Vector2

func setup(_damage_data: DamageData, _direction: Vector2):
	damage = _damage_data.amount
	speed = _damage_data.speed
	direction = _direction

func _process(delta: float) -> void:
	position = position.move_toward(direction, speed * delta)

"""
способ использування
var projectile = projectile_attack.instantiate()
projectile.setup(damage_data , direction)
projectile.global_position = global_position
add_child(projectile)
"""
