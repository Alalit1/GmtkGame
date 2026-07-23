class_name StateMachine
extends RefCounted

var current_state: State = null

func change_state(state: State):

	if current_state:
		current_state.exit()

	current_state = state

	current_state.enter()

func update(delta):

	if current_state:
		current_state.update(delta)
