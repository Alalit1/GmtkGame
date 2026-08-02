extends CharacterBody2D
class_name BaseEnemy


@export var enemy_data: EnemyData
@onready var brain = $Brain
@onready var component = $Component

func _ready() -> void:
	$Component/HealthComponent.daed.connect(_on_daed)
	brain.enemy_data = enemy_data
	# vision
	$AnimatedSprite2D.sprite_frames = enemy_data.sprite_frames
	component.enemy_data = enemy_data
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
	
func attack(pos):
	var direction = global_position.direction_to(pos)
	$Component/AttackComponent.attack(enemy_data.damage_data,direction,pos)

func _on_daed():
	queue_free()
