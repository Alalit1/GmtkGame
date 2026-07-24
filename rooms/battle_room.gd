extends Node2D

@onready var tilemap = $TileMap
@onready var spawner_node = $spawner

const width := 32
const height := 18
const id := 0

const wall := 0
const floor := 1
const exit := 2
const doorl := 3
const doorr := 4
const spawner := 5

var rng := RandomNumberGenerator.new()
var grid = []

var tile_coords = {
	0: Vector2i(0,0),
	1: Vector2i(1,0),
	2: Vector2i(2,0),
	3: Vector2i(3,0),
	4: Vector2i(4,0),
	5: Vector2i(5,0)
}

func _ready():
	G.connect("enemys_end", Callable(self, "open_the_doors"))
	rng.randomize()
	grid.clear()
	for y in height:
		grid.append([])
		for x in width:
			grid[y].append(wall)
	grid[0][15] = doorl
	grid[0][16] = doorr
	grid[height-1][15] = doorl
	grid[height-1][16] = doorr
	var spawners = spawn_spawners()
	for spawner in spawners:
		dig_corridor(spawner, Vector2i(16, 0))
		dig_corridor(spawner, Vector2i(16, 17))
	for y in height:
		for x in width:
			var atlas_coord = tile_coords[grid[y][x]]
			tilemap.set_cell(0, Vector2i(x,y), id, atlas_coord)
	open_the_doors()

func spawn_spawners() -> Array:
	var result = []
	var quadrants = [
		Rect2i(1, 1, 7, 5),
		Rect2i(24, 1, 7, 5),
		Rect2i(24, 12, 7, 5),
		Rect2i(1, 12, 7, 5),
	]
	for rect in quadrants:
		var x = rng.randi_range(rect.position.x, rect.position.x + rect.size.x - 1)
		var y = rng.randi_range(rect.position.y, rect.position.y + rect.size.y - 1)
		grid[y][x] = spawner
		spawner_node.position = Vector2(x*20+10, y*20+10)
		result.append(Vector2i(x,y))
		
	return result

func dig_corridor(start: Vector2i, target: Vector2i):
	var max_steps = 576
	while start.distance_to(target) > 1 and max_steps > 0:
		max_steps -= 1
		var dir = choose_direction(start, target)
		start += dir
		if is_border(start.x, start.y):
			continue
		carve_blob(start)

func choose_direction(current: Vector2i, target: Vector2i) -> Vector2i:
	var dirs = [
		Vector2i.LEFT,
		Vector2i.RIGHT,
		Vector2i.UP,
		Vector2i.DOWN
	]
	var best_dir = dirs[0]
	var best_score = -1000.0
	for dir in dirs:
		var next = current + dir
		if is_border(next.x, next.y):
			continue
		var dist_before = current.distance_to(target)
		var dist_after = next.distance_to(target)
		var score = dist_before - dist_after
		score += rng.randf_range(-1, 1)
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
				if grid[pos.y][pos.x] == wall:
					grid[pos.y][pos.x] = floor

func is_border(x:int, y:int) -> bool:
	return x <= 0 or y <= 0 or x >= width-1 or y >= height-1

func open_the_doors():
	grid[0][15] = exit
	grid[0][16] = exit
	var atlas_coord = tile_coords[2]
	tilemap.set_cell(0, Vector2i(15,0), id, atlas_coord)
	tilemap.set_cell(0, Vector2i(16,0), id, atlas_coord)
