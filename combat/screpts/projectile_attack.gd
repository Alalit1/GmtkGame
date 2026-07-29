extends Node2D
class_name ProjectileAttack

#@export var damage_data: DamageData
#var target_move := Vector2(500, 300)
var damage_data: DamageData
var speed : float
var damage: int
var direction: Vector2
var bullet


@onready var area = $DamageZone
@onready var timer =$Timer

func _ready():
	print($DamageZone)
	print(area)
	area.body_entered.connect(_on_hit)
"""
func attack(damage_data: DamageData, direction: Vector2, pos: Vector2):

	if is_instance_valid(bullet):
		return

	timer.start()

	bullet = area.instantiate()

	bullet.global_position = pos
	bullet.setup(damage_data, direction)

	get_tree().current_scene.add_child(bullet)
"""

	
func setup(_damage_data: DamageData, _direction: Vector2):
	damage_data = _damage_data
	speed = _damage_data.speed
	direction = _direction
	#area.initialize(damage_data)

func _process(delta):
	position += direction * speed * delta

func _on_hit(body):
	print("Попал в:", body.name)
	if body.has_method("take_damage"):
		body.take_damage(damage_data.amount)

	queue_free()
"""
способ использування
var projectile = projectile_attack.instantiate()
projectile.setup(damage_data , direction)
projectile.global_position = global_position
add_child(projectile)
"""
