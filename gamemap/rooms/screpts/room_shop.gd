extends RoomData
class_name RoomShop

# item 
@export var room_name : String = "shop"
@export var common_spawn_chance : float = 30.0

@export var special_spawn_chance : float = 100.0

@export var required_events: Array[DungeonEvent]
@export var next_event: Array[DungeonEvent]
