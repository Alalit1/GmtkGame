@tool
extends Node2D
class_name GenerateRoom


var generate_button = Callable()

var rng := RandomNumberGenerator.new()

enum Wall {
	TOP,
	RIGHT,
	BOTTOM,
	LEFT
}


@onready var tile_map = $Floor


func _ready() -> void:
	rng.randomize()

func generate_dor(enter_wall: RoomData.Wall) -> RoomData.Wall:
	var possible_walls: Array[RoomData.Wall] = []

	for wall in RoomData.Wall.values():
		if wall != enter_wall:
			possible_walls.append(wall)

	return possible_walls[rng.randi_range(0, possible_walls.size() - 1)]
	
	

func get_door_tiles(wall: RoomData.Wall, room_size: Vector2i) -> Array[Vector2i]:
	var tiles: Array[Vector2i]

	match wall:
		Wall.TOP:
			var x := room_size.x / 2 - 1
			tiles.append(Vector2i(x, 0))
			tiles.append(Vector2i(x + 1, 0))

		Wall.BOTTOM:
			var x := room_size.x / 2 - 1
			tiles.append(Vector2i(x, room_size.y - 1))
			tiles.append(Vector2i(x + 1, room_size.y - 1))

		Wall.LEFT:
			var y := room_size.y / 2 - 1
			tiles.append(Vector2i(0, y))
			tiles.append(Vector2i(0, y + 1))

		Wall.RIGHT:
			var y := room_size.y / 2 - 1
			tiles.append(Vector2i(room_size.x - 1, y))
			tiles.append(Vector2i(room_size.x - 1, y + 1))

	return tiles

func generate_enemy_spawn_points(
	room_data: RoomData,
	spawn_count: int
) -> void:

	room_data.enemy_spawn_points.clear()

	var possible_positions: Array[Vector2i] = []

	for y in range(1, room_data.height - 1):
		for x in range(1, room_data.width - 1):

			if room_data.get_cell(x, y) == RoomData.CellType.FLOOR:
				possible_positions.append(Vector2i(x, y))

	possible_positions.shuffle()

	var count: int = min(spawn_count, possible_positions.size())

	for i in range(count):
		room_data.enemy_spawn_points.append(
			possible_positions[i]
	)

func generate_room(room_data: RoomData) -> void:
	"""
		entrance_wall: Wall,
	exit_wall: Wall,
	enemy_spawn_count: int
	"""
	room_data.cells.resize(room_data.width * room_data.height)

	for y in range(room_data.height):
		for x in range(room_data.width):

			var index := y * room_data.width + x

			if x == 0 \
			or x == room_data.width - 1 \
			or y == 0 \
			or y == room_data.height - 1:

				room_data.cells[index] = RoomData.CellType.WALL
			else:
				room_data.cells[index] = RoomData.CellType.FLOOR

	# Двері
	var entrance_tiles := get_door_tiles(
		room_data.enter_wall,
		Vector2i(room_data.width, room_data.height)
	)

	var exit_tiles := get_door_tiles(
		room_data.exit_wall,
		Vector2i(room_data.width, room_data.height)
	)

	for tile in entrance_tiles:
		room_data.set_cell(
			tile.x,
			tile.y,
			RoomData.CellType.DOOR
		)

	for tile in exit_tiles:
		room_data.set_cell(
			tile.x,
			tile.y,
			RoomData.CellType.DOOR
		)

	# Точки спавну
	generate_enemy_spawn_points(room_data, room_data.enemy_spawn_count)

func get_opposite_wall(wall: RoomData.Wall) -> RoomData.Wall:
	match wall:
		RoomData.Wall.TOP:
			return RoomData.Wall.BOTTOM

		RoomData.Wall.RIGHT:
			return RoomData.Wall.LEFT

		RoomData.Wall.BOTTOM:
			return RoomData.Wall.TOP

		RoomData.Wall.LEFT:
			return RoomData.Wall.RIGHT

	return RoomData.Wall.LEFT


# сторуе карту послідовність кімнат на забег
func generate_map(room_data: RoomGenerateArray) -> Array[RoomData]:
	room_data.number_rooms = room_data.number_rooms + room_data.number_rooms -1
	var sequence_rooms: Array[RoomData] = []
	var event := RoomGenerateArray.DungeonEvent.FERST
	# Перша кімната заходить, наприклад, з LEFT
	var enter_wall: RoomData.Wall = RoomData.Wall.TOP
	
	for i in range(room_data.number_rooms):
		var room: RoomData = choose_room(room_data, event)
		var next_event = room.next_event
		if room == null:
			push_error("Не вдалося вибрати кімнату")
			break
		
		room.enter_wall = enter_wall
		# Якщо це передостання кімната
		if i == room_data.number_rooms - 4:
			next_event = RoomGenerateArray.DungeonEvent.PENULTIMATE_ROOM

		# Якщо це остання кімната (Boss)
		elif i == room_data.number_rooms - 2:
			next_event = RoomGenerateArray.DungeonEvent.LAST_ROOM
			room.exit_wall = room.enter_wall
		# Якщо є звичайний next_event
		elif room.next_event.is_empty():
			push_error(
				"EMPTY NEXT_EVENT! room=%s index=%d resource=%s"
				% [
					room.room_name,
					i,
					room.resource_path
				]
			)
			next_event = RoomGenerateArray.DungeonEvent.NONE

		else:
			next_event = room.next_event[0]
			room.exit_wall = generate_dor(room.enter_wall)
			
		sequence_rooms.append(room)
		
		if i < room_data.number_rooms - 1:
			enter_wall = get_opposite_wall(room.exit_wall)

		
		# Подія цієї кімнати стане подією наступного вибору
		event = next_event
	return sequence_rooms
# обраховуе яка комната беде в  яцейке
func choose_room(room_data: RoomGenerateArray,event:RoomData.DungeonEvent) ->RoomData:
	var total_choose: float = 0.0
	
	
	# 1. Рахуємо загальну суму шансів
	for room in room_data.generate_room_array:
		if room.required_events.has(event):
			if event == RoomData.DungeonEvent.NONE:
				total_choose += room.common_spawn_chance
			else:
				total_choose += room.special_spawn_chance

	print("Total chance: ", total_choose)

	# 2. Випадкове число від 0 до загальної суми
	var random_choose: float = rng.randf_range(0.0, total_choose)

	# 3. Проходимо ще раз і шукаємо, в який діапазон потрапило число
	for room in room_data.generate_room_array:
		if not room.required_events.has(event):
			continue

		var chance: float

		if event == RoomData.DungeonEvent.NONE:
			chance = room.common_spawn_chance
		else:
			chance = room.special_spawn_chance

		random_choose -= chance

		if random_choose <= 0.0:
			print("Selected: ", room.room_name)
			return room

	return null
