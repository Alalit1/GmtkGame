class_name EnemyData
extends Resource

@export_category("Characteristic")
@export var health  : float = 100
@export var speed : float = 50
@export var speed_up : float = 25
@export var detection_range : float = 100
@export var demeanor : String
## вожможні механіка
@export_group("Resistance")
# вожможні механікі
@export var ph : float
@export var fire : float
@export var venom : float
@export var ice : float
@export var rock : float
@export_category("Visuals")
@export var texture : Texture2D

@export_category("Sounds")

@export_category("Attack")
