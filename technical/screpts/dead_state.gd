class_name DeadState
extends State

func enter():
	brain.npc.velocity = Vector2.ZERO
	brain.npc.set_physics_process(false)

func update(delta):
	pass

func exit():
	pass
