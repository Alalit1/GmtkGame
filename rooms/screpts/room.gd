extends Node2D


@onready var tilemap: TileMap = $TileMap

const WIDTH := 32
const HEIGHT := 18

const TILE_SIZE := 20

const TILE_SOURCE_ID := 0


var tile_coords := {

	RoomConstants.WALL:
		Vector2i(0, 0),

	RoomConstants.FLOOR:
		Vector2i(1, 0),

	RoomConstants.EXIT:
		Vector2i(2, 0),

	RoomConstants.DOOR_LEFT:
		Vector2i(3, 0),

	RoomConstants.DOOR_RIGHT:
		Vector2i(4, 0)

}

var generator: RoomGenerator

var enemy_setup: RoomEnemySetup

var grid: Array = []

func _ready():

	# Подключаем сигнал окончания боя

	G.connect(
		"enemys_end",
		Callable(
			self,
			"open_the_doors"
		)
	)
	# Создаём генератор карты
	generator = RoomGenerator.new(
		WIDTH,
		HEIGHT
	)
	# Создаём менеджер позиций врагов
	enemy_setup = RoomEnemySetup.new()
	# Генерируем карту
	grid = generator.generate()
	# Получаем позиции врагов
	var enemy_positions := enemy_setup.get_spawn_positions()
	# Создаём коридоры
	for position in enemy_positions:

		generator.dig_corridor(
			position,
			Vector2i(16, 0)
		)
		generator.dig_corridor(
			position,
			Vector2i(
				16,
				HEIGHT - 1
			)
		)


	# Рисуем комнату

	draw_map()


	# Создаём врагов

	spawn_enemies(
		enemy_positions
	)

func draw_map():

	for y in HEIGHT:
		for x in WIDTH:

			var cell_type = grid[y][x]

			var atlas_coord: Vector2i = tile_coords[cell_type]

			tilemap.set_cell(
				0,
				Vector2i(x, y),
				TILE_SOURCE_ID,
				atlas_coord
			)
			
func open_the_doors():

	grid[0][15] = RoomConstants.EXIT
	grid[0][16] = RoomConstants.EXIT

	var atlas_coord: Vector2i = tile_coords[RoomConstants.EXIT]

	tilemap.set_cell(
		0,
		Vector2i(15, 0),
		TILE_SOURCE_ID,
		atlas_coord
	)

	tilemap.set_cell(
		0,
		Vector2i(16, 0),
		TILE_SOURCE_ID,
		atlas_coord
	)
func spawn_enemies(spawn_positions: Array[Vector2i]):

	for position in spawn_positions:

		var world_position := Vector2(
			position.x * 20 + 10,
			position.y * 20 + 10
		)

		SpawnManager.spawn_enemy(
			"goblin",
			world_position
		)
