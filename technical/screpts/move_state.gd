class_name MoveState
extends State

func update(delta):
	print("move")
	if brain.blackboard.target == null:
		return

	brain.move_to(brain.blackboard.last_known_position)
