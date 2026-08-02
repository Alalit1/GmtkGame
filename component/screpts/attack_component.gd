extends Node2D
class_name AttackComponent

@export var attack_scene: PackedScene


func attack(
	damage_data: DamageData,
	direction: Vector2,
	pos: Vector2
) -> void:

	if attack_scene == null:
		push_error("AttackComponent: attack_scene is not assigned")
		return

	var attack_instance := attack_scene.instantiate() as DamageZone

	get_tree().current_scene.add_child(attack_instance)

	attack_instance.global_position = pos
	attack_instance.rotation = direction.angle()

	attack_instance.setup(
		damage_data,
		direction
	)
