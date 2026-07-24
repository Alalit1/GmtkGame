extends Node2D

@onready var next_room = $next_room
@onready var current_room = $current_room
var new_room = preload("res://rooms/battle_room.tscn")

func _ready() -> void:
	var newroom = new_room.instantiate()
	next_room.add_child(newroom)
	newroom.position = Vector2(0,-360)

func _on_exit_body_entered(body: Node2D) -> void:
	g.room_finish += 1
	$player.exit()
	var newroom = new_room.instantiate()
	next_room.call_deferred("add_child", newroom)
	newroom.position = Vector2(0,-360)
	create_tween().tween_property(current_room.get_child(0), "position", Vector2(0, 360) ,0.5)
	await create_tween().tween_property(next_room.get_child(0), "position", Vector2(0, 0) ,0.5).finished
	current_room.get_child(0).queue_free()
	next_room.get_child(0).reparent(current_room)
	$player.exit()
	if g.room_finish % 21 == 0:
		pass
	elif g.room_finish % 20 == 0:
		pass
	else:
		new_room = preload("res://rooms/battle_room.tscn")
	
