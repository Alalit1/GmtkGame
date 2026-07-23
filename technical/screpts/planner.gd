class_name Planner
extends RefCounted

func choose_goal(brain) -> String:

	if brain.blackboard.target_position != null:
		if brain.blackboard.target == null:
			return "walking"
		else: 
			return "run"
	
	if brain.memory.last_target_position != null:
		return "walking"
		
	if brain.blackboard.enemy != null:
		return "attack"


	return "Idle"
