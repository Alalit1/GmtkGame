extends Node2D

@onready var next_room = $next_room
@onready var current_room = $current_room
var new_room = preload("res://rooms/screns/shop_room.tscn")

func _ready() -> void:
	
	var newroom = new_room.instantiate()
	next_room.add_child(newroom)
	newroom.position = Vector2(0,-360)

func _process(delta):
	
	if TimeGlobal.time > 0:
		TimeGlobal.time -= delta
		

func _on_exit_body_entered(body: Node2D) -> void:
	G.room_finish += 1
	if G.room_finish % 21 == 0:
		G.boss = true
		new_room = preload("res://rooms/screns/battle_room.tscn")
	elif G.room_finish % 2 == 1:
		new_room = preload("res://rooms/screns/shop_room.tscn")
		print(G.room_finish % 2)
	else:
		new_room = preload("res://rooms/screns/battle_room.tscn")
	$player.exit()
	var newroom = new_room.instantiate()
	next_room.call_deferred("add_child", newroom)
	newroom.position = Vector2(0,-360)
	create_tween().tween_property(current_room.get_child(0), "position", Vector2(0, 360) ,0.5)
	await create_tween().tween_property(next_room.get_child(0), "position", Vector2(0, 0) ,0.5).finished
	current_room.get_child(0).queue_free()
	next_room.get_child(0).reparent(current_room)
	G.emit_signal("start_spawn")
	$player.exit()
	
