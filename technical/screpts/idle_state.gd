class_name IdleState
extends State

func enter():
	brain.npc.move_direction = Vector2.ZERO
	brain.npc.current_speed = 0

func update(delta):

	if brain.blackboard.target != null:
		brain.state_machine.change_state(brain.states["move"])
