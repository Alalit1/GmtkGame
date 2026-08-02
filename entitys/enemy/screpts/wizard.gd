extends CharacterBody2D

var hp = 500
var damage = 10
var mana = 100
var spells = ["pikes", "teleport"]#, "shadowball", "necromance"]
var cast = ""
var casting = false
var free = []
var pike_scene = preload("res://combat/screens/shadow_pike.tscn")
@onready var recharge_timer = $recharge
@onready var sprite = $AnimatedSprite2D
var direction = 0

func _ready() -> void:
	G.connect("boss_start", Callable(self, "timer_start"))

func timer_sart():
	$recharge.start(5)

func take_damage(dmg):
	hp -= dmg

func _physics_process(delta: float) -> void:
	direction = global_position.angle_to_point(G.player_position)
	if mana < 100:
		mana += 0.1

func _on_recharge_timeout() -> void:
	if mana >= 10:
		casting = true
		cast = spells.pick_random()
		if direction >= -PI/4 and direction < PI / 4:
			sprite.play("cast_right")
			sprite.flip_h = false
		elif direction >= 3 * PI/4 or direction <= -3 * PI / 4:
			sprite.play("cast_right")
			sprite.flip_h = true
		elif direction >= -3 * PI/4 and direction < -PI / 4:
			sprite.play("cast_up")
			sprite.flip_h = false
		elif direction >= PI/4 and direction < 3 * PI / 4:
			sprite.play("cast_down")
			sprite.flip_h = false
		mana -= 10
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
	for pos in pike_cell:
		var pike = pike_scene.instantiate()
		add_child(pike)
		pike.global_position = pos

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

func _on_animated_sprite_2d_animation_finished() -> void:
	call(cast)
	casting = false
	
