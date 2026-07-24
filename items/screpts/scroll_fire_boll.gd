class_name FireballScroll
extends BaseItem

@export var damage_data: DamageData
@export var projectile_scene: PackedScene


func _on_use() -> void:
	var player = get_tree().get_first_node_in_group("player")

	if player:
		var projectile = projectile_scene.instantiate()

		projectile.damage_data = damage_data
		projectile.global_position = player.global_position

		player.get_parent().add_child(projectile)

func pick_up(player) -> void:
	
	if player.inventory.add_item(item_data):
		queue_free()
