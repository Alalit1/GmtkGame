extends Node2D
class_name ProjectileAttack

#@export var damage_data: DamageData
#var target_move := Vector2(500, 300)
var damage_data: DamageData
var speed : float
var damage: int
var direction: Vector2

@onready var area = $DamageZone

func _ready():
	area.body_entered.connect(_on_hit)

func setup(_damage_data: DamageData, _direction: Vector2):
	damage_data = _damage_data
	
	damage = _damage_data.amount
	speed = _damage_data.speed
	direction = _direction
	
	# Передаем DamageData в DamageZone
	area.initialize(damage_data)
	
func _process(delta):
	position += direction * speed * delta

func _on_hit(body):
	queue_free()
"""
способ использування
var projectile = projectile_attack.instantiate()
projectile.setup(damage_data , direction)
projectile.global_position = global_position
add_child(projectile)
"""
