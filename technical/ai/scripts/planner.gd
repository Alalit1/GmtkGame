class_name Planner
extends RefCounted


# плануання діл
func make_plan(blackboard: Blackboard) -> Action:
	var action := Action.new()

	if blackboard.target:
		var distance := blackboard.global_position.distance_to(
			blackboard.target.global_position
		)

		# Визначаємо напрямок до цілі
		var direction := blackboard.global_position.direction_to(
			blackboard.target.global_position
		)
		if distance <= blackboard.attack_range and blackboard.attack_type == "melee":
			action.type = Action.Type.ATTACK
			action.target = blackboard.target
			action.position = blackboard.target.global_position
			return action
		elif distance <= blackboard.long_range_attack_distance and blackboard.attack_type == "ranged":
			action.type = Action.Type.ATTACK
			action.target = blackboard.target
			action.position = blackboard.target.global_position
			return action
		action.type = Action.Type.MOVE
		action.target = blackboard.target
		action.position = blackboard.target.global_position
		return action
	else:
		action.type = Action.Type.IDLE
		action.target = blackboard.target
		return action	
	
"""if blackboard.target :
		action.type = Action.Type.ATTACK
		action.target = blackboard.target
		return action"""
