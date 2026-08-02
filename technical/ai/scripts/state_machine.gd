class_name StateMachine
extends RefCounted


var states: Dictionary = {}
var current_state: State = null
var current_state_name: String = ""


func add_state(state_name: String, state: State) -> void:
	states[state_name] = state


func change_state(state_name: String, action: Action = null) -> void:
	if not states.has(state_name):
		push_error("State not found: " + state_name)
		return

	if current_state_name == state_name:
		if action != null:
			current_state.set_action(action)
		return

	if current_state != null:
		current_state.exit()

	current_state = states[state_name]
	current_state_name = state_name

	if action != null:
		current_state.set_action(action)

	current_state.enter()


func update(delta: float) -> void:
	if current_state != null:
		current_state.update(delta)
