class_name MoveState
extends State

func update(delta):
	var next = brain.npc.navigation_agent.get_next_path_position()

	brain.npc.move_direction = (
		next - brain.npc.global_position
	).normalized()

	brain.npc.current_speed = brain.npc.walk_speed
	
