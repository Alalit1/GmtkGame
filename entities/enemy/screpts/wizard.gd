extends CharacterBody2D

var hp = 500
var damage = 10
var mana = 100
var spells = ["pikes", "teleport_preparation"]#, "shadowball", "necromance"]
var free = []
@onready var recharge_timer = $recharge

func take_damage(dmg):
	hp -= dmg

func _physics_process(delta: float) -> void:
	if mana < 100:
		mana += 0.1

func _on_recharge_timeout() -> void:
	if mana >= 10:
		var cast = spells.pick_random()
		mana -= 10
		call(cast)
	else:
		recharge_timer.start(16)

func pikes():
	var pike_cell = []
	var attack_cells = []
	for cell in G.free_cells:
		if G.player_position.distance_to(cell) < 90:
			attack_cells.append(cell)
	for i in 4:
		var cell = attack_cells.pick_random()
		attack_cells.erase(cell)
		pike_cell.append(cell)

func teleport():
	var safe_cells = []
	for cell in G.free_cells:
		if G.player_position.distance_to(cell) > 90:
			safe_cells.append(cell)
	position = safe_cells.pick_random()

func shadowball():
	pass

func necromance():
	pass
