extends Node

const ENEMY_SCENE: PackedScene = preload("res://entitys/enemy/screns/base_enemy.tscn")
const PLAYER_SCENE: PackedScene = preload("res://entitys/player/screns/base_player.tscn")



func spawn_enemy(enemy_id: String, position: Vector2) -> BaseEnemy:
	var data: EnemyData = EnemyDatabase.enemies.get(enemy_id)

	if data == null:
		push_error("Enemy '%s' not found" % enemy_id)
		return null

	var enemy: BaseEnemy = ENEMY_SCENE.instantiate()

	enemy.enemy_data = data
	enemy.global_position = position

	get_tree().current_scene.add_child(enemy)

	return enemy

func spawn():
	pass
