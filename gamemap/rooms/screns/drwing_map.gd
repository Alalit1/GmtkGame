extends Node2D

@onready var tilemap: TileMapLayer = $Floor
func draw_room(room_data: RoomData):
	draw_floor(room_data)
	draw_walls(room_data)
	draw_doors(room_data)
	spawn_enemies(room_data)

func spawn_enemies(room_data: RoomData) -> void:
	for spawn_point in room_data.enemy_spawn_points:
		var world_position := Vector2(spawn_point) * 16.0

		SpawnManager.spawn_enemy(
			"goblin",
			world_position
		)


func draw_floor(room_data: RoomData) -> void:
	for y in range(room_data.height):
		for x in range(room_data.width):
			var cell := room_data.get_cell(x, y)

			if cell == 0:
				#print("floor: ", x, ", ", y)
				tilemap.set_cell(
					Vector2i(x, y),
					0,
					Vector2i(1, 0)
				)
	
func draw_doors(room_data: RoomData) -> void:
	for y in range(room_data.height):
		for x in range(room_data.width):
			var cell := room_data.get_cell(x, y)

			if cell == 3:
				#print("dor: ", x, ", ", y)
				tilemap.set_cell(
					Vector2i(x, y),
					1,
					Vector2i(3, 0)
				)


func draw_walls(room_data: RoomData) -> void:
	for y in range(room_data.height):
		for x in range(room_data.width):
			var cell := room_data.get_cell(x, y) 
			if cell == 1:
				##print("WALL: ", x, ", ", y)
				tilemap.set_cell(
					Vector2i(x, y),
					2,
					Vector2i(0, 0)
				)
	# Верхня і нижня стіна
	"""for x in range(width):
		walls.set_cell(Vector2i(x, 0), WALL_SOURCE_ID, WALL_ATLAS_COORDS)
		walls.set_cell(Vector2i(x, height - 1), WALL_SOURCE_ID, WALL_ATLAS_COORDS)

	# Ліва і права стіна
	for y in range(1, height - 1):
		walls.set_cell(Vector2i(0, y), WALL_SOURCE_ID, WALL_ATLAS_COORDS)
		walls.set_cell(Vector2i(width - 1, y), WALL_SOURCE_ID, WALL_ATLAS_COORDS)
	"""
	"""
	# Двері
	var door_top := Vector2i(width / 2, 0)
	var door_bottom := Vector2i(width / 2, height - 1)

	walls.set_cell(door_top, 0, Vector2i(1, 0))
	walls.set_cell(door_bottom, 0, Vector2i(1, 0))
	"""
	
	
