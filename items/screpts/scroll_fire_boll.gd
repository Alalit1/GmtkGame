class_name FireballScroll
extends BaseItem

@export var damage_data: DamageData

@export var projectile_scene: PackedScene


var uses = 1
var max_uses
var heal_amout

@onready var tex = $Sprite2D

func _ready() -> void:

	tex.texture = item_data.texture
	max_uses = item_data.max_uses
	print('tet',input_pickable)

	
	cost = item_data.cost
	#label.visible = false
	label.text = item_data.name + "\n" + "Cost: "+ str(item_data.cost) + "\n" + item_data.description
	label.position.y = self.position.y
	label.position.x = self.position.x+ 40

	

func use(player) -> void:
	if uses <= 0:
		return
		
	player.fireball_cast(damage_data)
	uses -= 1

	if uses <= 0:
		queue_free()
