class_name Brain
extends Node

@onready var agent = $"../NavigationAgent2D"
@onready var vision = $"../VisionArea"

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

var npc: CharacterBody2D

func initialize(owner):
	npc = owner
	states["idle"].brain = self
	states["attack"].brain = self

	state_machine.change_state(states["attack"])
	
func update(delta):

	var goal = planner.choose_goal(self)

	state_machine.set_goal(goal)
	
func move_to(pos: Vector2):
	npc.navigation_agent.target_position = pos
