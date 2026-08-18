extends CharacterBody2D
class_name BaseEnemy

var can_attack := true

@export var attack_cooldown := 1.0
@export var enemy_data: EnemyData
@onready var brain = $Brain
@onready var component = $Component

func _ready() -> void:
	print("___",enemy_data)
	brain.setup(enemy_data)
	component.setup(enemy_data)
	$Component/HealthComponent.daed.connect(_on_daed)
	
	# vision sprite_frames
	
	$AnimatedSprite2D.sprite_frames = enemy_data.sprite_frames
	
	# установка столкновений
	$CollisionShape2D.shape.radius = enemy_data.radius
	$CollisionShape2D.shape.height = enemy_data.height
	
	for i in enemy_data.layer:
		set_collision_layer_value(i,true)
	for i in enemy_data.mask:
		set_collision_mask_value(i,true)
	
	
func move_to(pos: Vector2):
	
	var direction = global_position.direction_to(pos)
	velocity = direction * enemy_data.speed
	move_and_slide()
	
func attack(target_pos: Vector2):
	if not can_attack:
		return

	can_attack = false
	var direction := global_position.direction_to(target_pos)
	var attack_pos := global_position + direction * 20
	

	$Component/AttackComponent.attack(
		enemy_data.damage_data,
		direction,
		attack_pos
	)
	await get_tree().create_timer(attack_cooldown).timeout

	can_attack = true
func escape():
	print(" escaope")

func _on_daed():
	queue_free()
