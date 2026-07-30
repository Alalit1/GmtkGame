extends Node
class_name Component

@export var enemy_data : EnemyData
@onready var characteristic = $Characteristic
@onready var hitbox_component = $HitboxComponent/CollisionShape2D

func _ready() -> void:
	characteristic.setup(enemy_data)
	hitbox_component.shape.raius = enemy_data.raius
	hitbox_component.shape.height = enemy_data.height
	hitbox_component.debug_color = enemy_data.debug_color
	
