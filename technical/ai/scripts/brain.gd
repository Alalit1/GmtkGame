class_name Brain
extends Node

@export var enemy_data: EnemyData

@onready var vision = $Sensors/VisionArea
@onready var vision_shape = $Sensors/VisionArea/CollisionShape2D
@onready var sensors = $Sensors



var memory := Memory.new()
var planner := Planner.new()
var blackboard := Blackboard.new()

var state_machine := StateMachine.new()

func _ready() -> void:
	var enemy := get_parent() as CharacterBody2D

	if enemy == null:
		push_error("Brain: Parent is not CharacterBody2D")
		return

	# Створюємо стани
	var idle_state := IdleState.new(enemy)
	var move_state := MoveState.new(enemy)
	var attack_state := AttackState.new(enemy)

	# Додаємо стани до машини
	state_machine.add_state("Idle", idle_state)
	state_machine.add_state("Move", move_state)
	state_machine.add_state("Attack", attack_state)

	# Початковий стан
	state_machine.change_state("Idle")
	
	for i in enemy_data.layer:
		vision.set_collision_layer_value(i,true)
	for i in enemy_data.mask:
		vision.set_collision_mask_value(i,true)

	vision_shape.shape.radius = enemy_data.vision_area
		
	
func _process(_delta):
	
	
	blackboard.target = sensors.target
	blackboard.global_position = self.global_position

	var action := planner.make_plan(blackboard)

	match action.type:

		Action.Type.MOVE:

			state_machine.change_state("Move", action)
			get_parent().move_to(action.position)

		Action.Type.ATTACK:
			state_machine.change_state("Attack", action)
			get_parent().attack(action.position)

		Action.Type.IDLE:
			state_machine.change_state("Idle", action)

	state_machine.update(_delta)
	


	#npc.navigation_agent.target_position = pos
