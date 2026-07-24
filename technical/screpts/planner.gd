class_name Planner
extends RefCounted

enum Goal {
	IDLE,
	MOVE,
	ATTACK,
	DEAD
}

func choose_goal(blackboard: Blackboard) -> Goal:
	if blackboard.target_visible:
		return Goal.ATTACK

	if blackboard.last_known_position != Vector2.ZERO:
		return Goal.MOVE

	return Goal.IDLE

"""


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
"""
