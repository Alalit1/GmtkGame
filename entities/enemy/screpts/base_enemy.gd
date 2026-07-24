extends CharacterBody2D

#@export var walk_speed := 120.0
#@export var run_speed := 220.0
@export var enemy_data : EnemyData

@onready var brain: Brain = $Brain
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

var move_direction := Vector2.ZERO
var current_speed := 0.0

func _ready() -> void:
	
	$Component/Characteristic.setup(enemy_data)

	brain.initialize(self)
	#$Sprite2D.texture = ch.texture
	
func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var next = navigation_agent.get_next_path_position()
	var direction = global_position.direction_to(next)

	velocity = direction * current_speed
	move_and_slide()
