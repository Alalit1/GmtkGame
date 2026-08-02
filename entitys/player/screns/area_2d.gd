extends Area2D


func _on_area_entered(area:Area2D) -> void:
	if area is DamageZone:
		get_parent().take_damage(10.0)
