extends Node


var scenes: Dictionary = {
	"enemy_goblin": preload("res://entities/enemy/screns/goblin.tscn")
}

func spawn(type: String, position: Vector2, parent: Node = null) -> Node:
	if not scenes.has(type):
		print("Помилка: тип '", type, "' не знайдено")
		return null
	
	var instance = scenes[type].instantiate()
	instance.global_position = position
	
	if parent:
		parent.add_child(instance)
	else:
		# Якщо батько не вказаний, додаємо на поточну сцену
		var root = get_tree().current_scene
		root.add_child(instance)
	
	return instance


func spawn_enemy(enemy_type: String, pos: Vector2):
	return spawn("enemy_" + enemy_type, pos)
