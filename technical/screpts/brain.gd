class_name Brain
extends Node

@onready var characteristic: Characteristic = $"../Component/Characteristic"
@onready var agent = $"../NavigationAgent2D"
@onready var vision = $Sensors/VisionArea
@onready var vision_shape = $Sensors/VisionArea/CollisionShape2D
@onready var sensors = $Sensors

var memory := Memory.new()
var planner := Planner.new()
var blackboard := Blackboard.new()

var state_machine:= StateMachine.new()

var states := {
	"idle": IdleState.new(),
	"attack": AttackState.new(),
	"daed": DeadState.new(),
	"move": MoveState.new()
}

func _ready() -> void:
	var character := get_parent() as CharacterBody2D
	vision.position = character.position
	var shape := CircleShape2D.new()
	shape.radius = 100.0#characteristic.vision_area
	vision_shape.shape = shape
		
	
var npc: CharacterBody2D

func initialize(owner):
	npc = owner
	
	for state in states.values():
		state.brain = self

	state_machine.change_state(states["idle"])
	
func update_blackboard():
	blackboard.target = sensors.target
	blackboard.target_visible = sensors.can_see_target

	if sensors.target:
		blackboard.target_position = sensors.target.global_position
		blackboard.last_known_position = sensors.target.global_position

func update(delta):

	var goal = planner.choose_goal(self)

	state_machine.set_goal(goal)
	
func move_to(pos: Vector2):
	npc.navigation_agent.target_position = pos
