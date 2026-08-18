class_name EnemyData
extends Resource


@export_category("tex")
@export var id : String
@export_enum("enemy","player") var entity_type : int = 0
@export_category("Colision")
@export_group("Size")
## высота colision
@export var height : float
## шырына colision
@export var radius : float
@export_group("mask $ layer")
@export var debug_color:Color =Color(0.0, 1.0, 0.0)
@export var mask : Array[int] = [3]
@export var layer : Array[int] = [2,3,4]
@export_category("Characteristic")
## здорове
@export var health  : float = 100
## скорость
@export var speed : float = 50
## урон
@export var damage: float = 20
##
@export var stamina: float = 20
## радийс зрения
@export var vision_area : float = 100
## ускорение
@export var speed_up : float = 25
## вожможні механіка
@export_group("Resistance")
##
@export var ph : float
##
@export var fire : float
##
@export var venom : float
##
@export var ice : float
##
@export var rock : float
@export_category("Visuals")
##
@export var sprite_frames : SpriteFrames

@export_category("Sounds")
##
@export var sound_list = AudioStreamPlaylist 
@export_category("Attack")
enum AttackType {
	MELEE,
	RANGED,
	WIZARD
}


@export var damage_data : DamageData
@export var attack_type: AttackType = AttackType.MELEE
