extends RoomData
class_name RoomCorridor

@export var room_name : String = "cor"
@export var common_spawn_chance : float = 0.0

@export var special_spawn_chance : float = 50.0

@export var required_events: Array[DungeonEvent]
@export var next_event: Array[DungeonEvent]
