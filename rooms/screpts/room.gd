extends Node2D

@onready var tilemap: TileMap = $TileMap

const WIDTH := 32
const HEIGHT := 18
const SOURCE_ID := 0

const WALL := 0
const FLOOR := 1
const PASSAGE := 2
const DOORL := 3
const DOORR := 4
const SPAWNER := 5

var rng := RandomNumberGenerator.new()
var grid = []
@onready var spawner_node = $spawner

var tile_coords = {
	0: Vector2i(0,0),
	1: Vector2i(1,0),
	2: Vector2i(2,0),
	3: Vector2i(3,0),
	4: Vector2i(4,0),
	5: Vector2i(5,0)
}

func _ready():
	G.connect("enemys_end", Callable(self, "enemys_end"))
	rng.randomize()
	for y in range(HEIGHT):
		grid.append([])
		for x in range(WIDTH):
			grid[y].append(WALL)
	grid[0][15] = DOORL
	grid[0][16] = DOORR
	grid[HEIGHT-1][15] = DOORL
	grid[HEIGHT-1][16] = DOORR
	var spawners = spawn_spawners()
	for spawner in spawners:
		connect_to_passages(spawner)
	for y in range(HEIGHT):
		for x in range(WIDTH):
			var atlas_coord = tile_coords[grid[y][x]]
			tilemap.set_cell(0, Vector2i(x, y), SOURCE_ID, atlas_coord)
	for y in range(1, HEIGHT-1):
		for x in range(1,WIDTH-1):
			if grid[y][x] == FLOOR:
				G.free_cells.append(Vector2(x, y) * 20 + Vector2(10, 10))

func enemys_end():
	grid[0][15] = PASSAGE
	grid[0][16] = PASSAGE

func spawn_spawners() -> Array:
	var result = []
	var half_w = WIDTH / 2
	var half_h = HEIGHT / 2
	var quadrants := [
		Rect2i(1, 1, 7, 5),
		Rect2i(24, 1, 7, 5),
		Rect2i(24, 12, 7, 5),
		Rect2i(1, 12, 7, 5)
	]
	for rect in quadrants:
		var x = rng.randi_range(rect.position.x, rect.position.x + rect.size.x - 1)
		var y = rng.randi_range(rect.position.y, rect.position.y + rect.size.y - 1)
		grid[y][x] = SPAWNER
		result.append(Vector2i(x,y))
		var pos = Vector2i(x,y) * 20 + Vector2i(10,10)
		spawner_node.preparation(pos)
	return result

func connect_to_passages(start: Vector2i):
	dig_corridor(start, Vector2i(16, 0))
	dig_corridor(start, Vector2i(16, 17))

func dig_corridor(start: Vector2i, target: Vector2i):
	var current = start
	var max_steps = 576
	while current.distance_to(target) > 1 and max_steps > 0:
		max_steps -= 1
		var dir = choose_direction(current, target)
		current += dir
		if is_border(current.x, current.y):
			continue
		carve_blob(current)

func choose_direction(current: Vector2i, target: Vector2i) -> Vector2i:
	var dirs = [
		Vector2i.LEFT,
		Vector2i.RIGHT,
		Vector2i.UP,
		Vector2i.DOWN
	]
	var best_dir = dirs[0]
	var best_score = -9999.0
	for dir in dirs:
		var next = current + dir
		if is_border(next.x, next.y):
			continue
		var dist_before = current.distance_to(target)
		var dist_after = next.distance_to(target)
		var score = dist_before - dist_after
		score += rng.randf_range(-1.0, 1.0)
		if score > best_score:
			best_score = score
			best_dir = dir
	return best_dir

func carve_blob(center: Vector2i):
	for dy in range(-1, 2):
		for dx in range(-1, 2):
			var pos = center + Vector2i(dx,dy)
			if is_border(pos.x, pos.y):
				continue
			if Vector2(dx,dy).length() <= 1:
				if grid[pos.y][pos.x] == WALL:
					grid[pos.y][pos.x] = FLOOR

func is_border(x:int, y:int) -> bool:
	return x <= 0 or y <= 0 or x >= WIDTH-1 or y >= HEIGHT-1
