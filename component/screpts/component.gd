extends Node
class_name Component


@onready var characteristic = $Characteristic
@onready var hitbox_component = $HitboxComponent/CollisionShape2D

"""
var health: float
var damage: float
var stamina : float
var speed : float
var speed_up : float
var vision_area : float

var texture : Texture2D
"""
func setup(enemy_data):
	print("test",enemy_data.health)
	characteristic.entity_type = enemy_data.entity_type
	characteristic.health = enemy_data.health
	characteristic.damage = enemy_data.damage
	print("test2 ", characteristic.health)
	$HealthComponent.setup()
	characteristic.stamina = enemy_data.stamina
	characteristic.speed = enemy_data.speed
	characteristic.speed_up = enemy_data.speed_up
	
	characteristic.vision_area = enemy_data.vision_area
	
	#characteristic.texture = enemy_data.sprite_frame

	hitbox_component.shape.radius = enemy_data.radius
	hitbox_component.shape.height = enemy_data.height
	hitbox_component.debug_color = enemy_data.debug_color
	print(enemy_data.entity_type)
	$HitboxComponent.collision_layer = 0
	$HitboxComponent.collision_mask = 0
	for i in enemy_data.layer:
		$HitboxComponent.set_collision_layer_value(i,true)
		print("__",$HitboxComponent.collision_layer,'__',$HitboxComponent.collision_mask)
	for i in enemy_data.mask:
		$HitboxComponent.set_collision_mask_value(i,true)
		print("_",$HitboxComponent.collision_layer,$HitboxComponent.collision_mask)
	
	print("HITBOX:", $HitboxComponent)
	print("LAYER:", $HitboxComponent.collision_layer)
	print("MASK:", $HitboxComponent.collision_mask)
	#print("SHAPE:", $HitboxComponent.shape)
	#print("DISABLED:", $HitboxComponent.disabled)
		
