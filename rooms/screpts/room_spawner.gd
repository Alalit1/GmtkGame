class_name RoomSpawner
extends RefCounted

var rng := RandomNumberGenerator.new()

func _init():
	rng.randomize()


func get_spawn_positions() -> Array[Vector2i]:

	var result: Array[Vector2i] = []

	var quadrants := [
		Rect2i(1, 1, 7, 5),
		Rect2i(24, 1, 7, 5),
		Rect2i(24, 12, 7, 5),
		Rect2i(1, 12, 7, 5)
	]

	for rect in quadrants:
		var x := rng.randi_range(
			rect.position.x,
			rect.position.x + rect.size.x - 1
		)

		var y := rng.randi_range(
			rect.position.y,
			rect.position.y + rect.size.y - 1
		)

		result.append(Vector2i(x, y))

	return result
