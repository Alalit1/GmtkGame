extends Node
#глобальный скрипт
signal enemys_end
signal enemy_dead
signal start_spawn
signal boss_cast
signal boss_start

var free_cells = []
var time = 600.0
var room_finish = 19
var player_position = Vector2.ZERO
var boss = false
