extends Node

var enemies: Dictionary = {}

const PATH := "res://entitys/enemy/resource/"


func _ready() -> void:
	load_enemies()


func load_enemies() -> void:
	var dir := DirAccess.open(PATH)

	if dir == null:
		push_error("Не знайдено папку: " + PATH)
		return

	dir.list_dir_begin()

	var file_name := dir.get_next()

	while file_name != "":
		if not dir.current_is_dir() and file_name.ends_with(".tres"):
			var data: EnemyData = load(PATH + file_name)

			if data:
				enemies[data.id] = data
				
		#print(EnemyDatabase.enemies)
		file_name = dir.get_next()
	#print(EnemyDatabase.enemies)
	
	dir.list_dir_end()
