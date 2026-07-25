extends CharacterBody2D
class_name BaseEnemy

#@export var walk_speed := 120.0
#@export var run_speed := 220.0
@export var enemy_data : EnemyData

#@onready var brain: Brain = $Brain
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var vision : VisionArea = $VisionArea

var move_direction := Vector2.ZERO
var current_speed := 0.0

func _ready() -> void:
	
	$Component/Characteristic.setup(enemy_data)
	vision.radius = enemy_data.vision_area

func _physics_process(_delta):
	if vision.target == null:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	
	var distance = global_position.distance_to(vision.target.global_position)
	var target_point = vision.target.global_position + vision.target.global_position.direction_to(global_position) * 40
	
	if distance <= 50:
		#attack(damage_data, distance,target_point)
		velocity = Vector2.ZERO
	else:
		print("move")
		var direction = global_position.direction_to(vision.target.global_position)
		velocity = direction * current_speed
	print("move")
	move_and_slide()
	
func attack(damage_data:DamageData, direction: Vector2, pos: Vector2):
	pass
