extends Node

const ENEMY_SCENE: PackedScene = preload("res://entitys/enemy/screns/base_enemy.tscn")

func spawn_enemy(enemy_id: String, position: Vector2) -> BaseEnemy:
	var data: EnemyData = EnemyDatabase.enemies.get(enemy_id)
	print(enemy_id)
	print(EnemyDatabase.enemies.keys())
	print(data)
	print(data.health)
	if data == null:
		push_error("Enemy '%s' not found" % enemy_id)
		return null

	var enemy: BaseEnemy = ENEMY_SCENE.instantiate()

	enemy.enemy_data = data
	print("___",enemy.enemy_data)
	enemy.global_position = position

	get_tree().current_scene.add_child(enemy)

	return enemy

func spawn():
	pass
