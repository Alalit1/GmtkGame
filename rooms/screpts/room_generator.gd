class_name RoomGenerator
extends RefCounted

var width: int
var height: int
var rng := RandomNumberGenerator.new()

var grid: Array = []

func _init(room_width: int, room_height: int):
	width = room_width
	height = room_height
	rng.randomize()


func generate() -> Array:
	grid.clear()

	# Создаём карту, заполненную стенами
	for y in height:
		grid.append([])

		for x in width:
			grid[y].append(RoomConstants.WALL)

	# Создаём двери
	grid[0][15] = RoomConstants.DOOR_LEFT
	grid[0][16] = RoomConstants.DOOR_RIGHT

	grid[height - 1][15] = RoomConstants.DOOR_LEFT
	grid[height - 1][16] = RoomConstants.DOOR_RIGHT

	return grid
func dig_corridor(start: Vector2i, target: Vector2i):
	var max_steps := width * height

	while start.distance_to(target) > 1 and max_steps > 0:
		max_steps -= 1

		var direction := choose_direction(start, target)
		start += direction

		if is_border(start.x, start.y):
			continue

		carve_blob(start)
		
func choose_direction(
	current: Vector2i,
	target: Vector2i
) -> Vector2i:

	var dirs: Array[Vector2i] = [
		Vector2i.LEFT,
		Vector2i.RIGHT,
		Vector2i.UP,
		Vector2i.DOWN
	]

	var best_dir: Vector2i = dirs[0]
	var best_score: float = -1000.0

	for direction: Vector2i in dirs:

		var next: Vector2i = current + direction

		if is_border(next.x, next.y):
			continue

		var dist_before: float = current.distance_to(target)
		var dist_after: float = next.distance_to(target)

		var score: float = dist_before - dist_after

		score += rng.randf_range(-1.0, 1.0)

		if score > best_score:
			best_score = score
			best_dir = direction

	return best_dir

func carve_blob(center: Vector2i):
	for dy in range(-1, 2):
		for dx in range(-1, 2):
			var pos := center + Vector2i(dx, dy)

			if is_border(pos.x, pos.y):
				continue

			if Vector2(dx, dy).length() <= 1:
				if grid[pos.y][pos.x] == RoomConstants.WALL:
					grid[pos.y][pos.x] = RoomConstants.FLOOR

func is_border(x: int, y: int) -> bool:
	return (
		x <= 0
		or y <= 0
		or x >= width - 1
		or y >= height - 1
	)
