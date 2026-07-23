extends CharacterBody2D

@export var walk_speed := 120.0
@export var run_speed := 220.0

@onready var ch := $Component/Characteristic
@onready var brain: Brain = $Brain
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

var move_direction := Vector2.ZERO
var current_speed := 0.0

func _ready() -> void:
	brain.initialize(self)
	$Sprite2D.texture = ch.texture
	
func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		move_direction = Vector2.ZERO
	else:
		var next = navigation_agent.get_next_path_position()
		move_direction = (
			next - global_position
		).normalized()

	velocity = move_direction * current_speed

	move_and_slide()
