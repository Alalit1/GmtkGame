class_name DamageZone
extends Area2D

signal hit(body)
@export var damage_data: DamageData
@onready var shape = $CollisionShape2D.shape
var targets: Array[Node] = []


var direction: Vector2


func setup(
	_damage_data: DamageData,
	_direction: Vector2
) -> void:
	damage_data = _damage_data
	direction = _direction.normalized()


func _ready() -> void:
	shape.radius = 10


func initialize(data: DamageData):
	damage_data = data
	

	var circle := $CollisionShape2D.shape as CircleShape2D
	if circle == null:
		push_error("У CollisionShape2D не назначен CircleShape2D")
		return

	circle.radius = damage_data.radius

func _on_body_entered(body: CharacterBody2D) -> void:
	#print("test",body)
	if body.has_method("take_damage"):
		print("test","______",body.is_in_group("player"))
		targets.append(body)
		apply_damage()
		
	hit.emit(body)

func _on_body_exited(body: Node) -> void:
	if body in targets:
		targets.erase(body)


func apply_damage() -> void:
	print("test","__ataa_")
	var damage := Damage.new()

	for target in targets:
		print("se")
		damage.apply_damage(damage_data, target)
