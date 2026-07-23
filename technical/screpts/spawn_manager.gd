extends Node

# Словник з усіма типами об'єктів для спавну
var scenes: Dictionary = {
	#"npc_trader": preload("res://scenes/npcs/trader.tscn"),
	#"npc_trader": preload("res://scenes/npcs/trader.tscn"),
	#"npc_adventure": preload("res://npc/screens/adventurer.tscn"),
	#"npc_trader": preload("res://npc/screens/trader.tscn"),
	#"enemy_goblin": preload("res://enamy/screen/goblin.tscn")
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

# Зручні методи-обгортки
func spawn_enemy(enemy_type: String, pos: Vector2):
	return spawn("enemy_" + enemy_type, pos)

func spawn_npc(npc_type: String, pos: Vector2):
	return spawn("npc_" + npc_type, pos)
