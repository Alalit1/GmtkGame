class_name StaminaEffect
extends ItemEffect

@export var duration: float = 10.0


func apply(user: Node) -> void:
	if user.has_method("set_stamina_infinite"):
		user.set_stamina_infinite(true)

	await user.get_tree().create_timer(duration).timeout

	if is_instance_valid(user):
		user.set_stamina_infinite(false)
