class_name Item
extends Area2D

@export var item_data: ItemData

var player_in_range: bool = false
var player: Node = null


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		player = body


func _on_body_exited(body: Node) -> void:
	if body == player:
		player_in_range = false
		player = null


func pickup() -> void:
	if not player_in_range:
		return

	if player.has_method("add_item"):
		var success: bool = player.add_item(item_data)

		if success:
			queue_free()
