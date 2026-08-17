extends Resource
class_name RoomData

@export_category("Size")
@export var width : int = 44
@export var height : int = 23
#@export var number_rooms: int
@export var enemy_spawn : bool =false
@export var enemy: Array[EnemyData]
@export var curent_enemy: int = 1
@export var cells: Array[int] = [
	1, 1, 1, 1, 1,
	1, 0, 0, 0, 1,
	1, 0, 0, 0, 1,
	1, 1, 1, 1, 1
]

func initialize() -> void:
	cells.resize(width * height)

	for i in cells.size():
		cells[i] = 0


func get_cell(x: int, y: int) -> int:
	if x < 0 or x >= width:
		push_error("X out of bounds: %d" % x)
		return -1

	if y < 0 or y >= height:
		push_error("Y out of bounds: %d" % y)
		return -1

	var index := y * width + x

	if index >= cells.size():
		push_error(
			"Cells too small! index=%d size=%d width=%d height=%d"
			% [index, cells.size(), width, height]
		)
		return -1

	return cells[index]


func set_cell(x: int, y: int, value: int) -> void:
	cells[y * width + x] = value
	
	
@export_enum("Battale","Shop","Boss_battle","Corridor") var room_type : int
@export_category("Filled")
enum Wall {
	TOP,
	RIGHT,
	BOTTOM,
	LEFT
}
enum DungeonEvent {
	NONE,
	LAST_ROOM,
	FERST,
	PENULTIMATE_ROOM,
	AFTER_THE_ROOM
}
enum RoomType {
	ROOM,
	CORRIDOR
}

@export var room_types: RoomType = RoomType.ROOM
enum CellType {
	FLOOR,
	WALL,
	EMPTY,
	DOOR,
	SPAWN
}

@export var tile_set : TileSet
@export var enemy_spawn_count: int = 1
@export var enemy_spawn_points: Array[Vector2i] = []

@export var enter_wall: Wall
@export var exit_wall: Wall
