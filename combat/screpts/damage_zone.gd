class_name DamageZone
extends Area2D

signal hit(body)


@export var damage_data: DamageData
@export var speed: float = 300.0
@onready var sprite = $Sprite2D
var attack_type

var targets: Array[Area2D] = []
var direction: Vector2


func setup(
	_damage_data: DamageData,
	_direction: Vector2
) -> void:
	damage_data = _damage_data
	direction = _direction.normalized()
	var circle := $CollisionShape2D.shape as CircleShape2D

	if circle == null:
		push_error("У CollisionShape2D не назначен CircleShape2D")
		return

	circle.radius = damage_data.radius

	if damage_data.sprite != null:
		sprite.texture = damage_data.sprite
		sprite.visible = true

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	attack_type = damage_data.attacktype


	var circle := $CollisionShape2D.shape as CircleShape2D
	if damage_data.sprite != null:
		sprite.texture = damage_data.sprite 
		sprite.visible = true
	if circle == null:
		push_error("У CollisionShape2D не назначен CircleShape2D")
		return

	circle.radius = damage_data.radius


func _physics_process(delta: float) -> void:
	if damage_data.attacktype ==1:
		global_position += direction * speed * delta


func apply_damage() -> void:
	var damage := Damage.new()

	for target in targets:
		damage.apply_damage(damage_data, target)
		#queue_free()


func _on_area_entered(area: Area2D) -> void:
	
	if area is not HitboxComponent:
		return

	print("ПОПАВ У HITBOX: ", area)
	
	hit.emit(area)
	
	var hitbox := area as HitboxComponent

	hitbox.take_damage(damage_data.amount)
	#if damage_data.attacktype == 1:
	queue_free()


#func _on_area_exited(area: Area2D) -> void:
	#if area is HitboxComponent:
		#if area in targets:
		#	targets.erase(area)
