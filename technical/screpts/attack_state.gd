class_name AttackState
extends State

func update(delta):
	var enemy = brain.blackboard.enemy

	if enemy == null:
		return
	if enemy:
		brain.move_to(enemy.global_position)
