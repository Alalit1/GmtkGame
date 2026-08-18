extends RoomData
class_name RoomBattleBoss

@export var room_name : String = "Battales Box"
@export var common_spawn_chance : float = 0.0

@export var special_spawn_chance : float = 100.0

@export var required_events: Array[DungeonEvent]
@export var next_event: Array[DungeonEvent]
