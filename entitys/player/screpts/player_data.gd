extends Resource
class_name PlayerData


@export_category("Technical")

@export var id: String
@export_enum("enemy","player") var entity_type : int = 1

@export_category("Stats")

@export var speed := 100.0
@export var speed_up := 550.0
@export var health := 100.0
@export var damage := 20.0
@export var stamina := 100.0

@export_category("Attributes")

@export var vision_area : float = 50
@export var radius : float = 20
@export var height : float = 20
@export var debug_color: Color
@export var damage_data: DamageData

@export_category("Collision")
@export var layer : Array[int] = [3,4]
@export var mask : Array[int] = [2]


"""
@export var dash_cooldown := false
@export var dashing := false
@export var last_direction := Vector2(1,0)
@export var attack_charging := false
@export var charge := 1.0
@export var combo := 9.0
@export var can_dash = true
@export var can_charge = true
@export var can_combo = true
"""
