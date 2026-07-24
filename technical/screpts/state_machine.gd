class_name StateMachine
extends RefCounted

var states: Dictionary
var current_state = null


func initialize(states_dict: Dictionary):
	states = states_dict


func set_goal(goal: Planner.Goal):
	match goal:
		Planner.Goal.IDLE:
			change_state(states["idle"])

		Planner.Goal.MOVE:
			change_state(states["move"])

		Planner.Goal.ATTACK:
			change_state(states["attack"])

		Planner.Goal.DEAD:
			change_state(states["dead"])


func change_state(new_state):
	if current_state == new_state:
		return

	# Виходимо з попереднього стану
	if current_state:
		current_state.exit()

	# Змінюємо стан
	current_state = new_state

	# Входимо в новий стан
	if current_state:
		current_state.enter()
