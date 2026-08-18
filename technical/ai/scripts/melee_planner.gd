class_name MeleePlanner
extends Planner

func make_plan(blackboard: Blackboard) -> Action:
	var action := Action.new()

	if not blackboard.target:
		action.type = Action.Type.IDLE
		return action

	var target_position: Vector2 = blackboard.target.global_position
	var distance := blackboard.global_position.distance_to(
		blackboard.target.global_position
	)

	if distance <= blackboard.attack_range :
		action.type = Action.Type.ATTACK
		action.position = target_position
	else:
		action.type = Action.Type.MOVE
		action.position = target_position

	action.target = blackboard.target

	return action
