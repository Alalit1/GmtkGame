extends CharacterBody2D

class_name Player

signal hp_changed(new_hp)
signal stamina_changed(new_stamina)
signal daed()
signal esc()
var inventore = []

@export var speed := 100.0
@export var max_hp := 100.0
@export var hp := 100.0
@export var damage := 20.0
var _stamina := 100.0
@export var projectile_attack: PackedScene
@export var damage_data: DamageData
@export var stamina: float:
	get:
		return _stamina
	set(value):
		_stamina = clamp(value, 0.0, max_stamina)
		stamina_changed.emit(_stamina)
@export var max_stamina := 100.0


var dash_cooldown := false
var dashing := false
var last_direction := Vector2(0,1)
var attack_charging := false
var charge := 1.0
var combo := 9.0
var can_dash = true
var can_charge = true
var can_combo = true
var transition = false
var inf_stamina = false

@onready var inf_stamina_timer = $inf_stamina_timer
@onready var attack_area = $attack_area
@onready var player_animator = $AnimationPlayer
@onready var player_sprite = $AnimatedSprite2D
@onready var player_sounds = $AudioStreamPlayer2D
@onready var ui = $CanvasLayer/PlayerUI



func _ready() -> void:
	ui.inventore = inventore
	ui.player = self
	
func use_item(index: int):
	if index >= PlayerInventore.inventore.size():
		return

	var item: BaseItem = PlayerInventore.inventore[index]

	if !is_instance_valid(item):
		PlayerInventore.inventore.remove_at(index)
		PlayerInventore.inventory_changed.emit()
		return

	item.use(self)

	PlayerInventore.inventore.remove_at(index)
	PlayerInventore.inventory_changed.emit()
	item.free()

func _input(event):
	if event.is_action_pressed("slot_1"):
		use_item(0)
	#if event.is_action_pressed("Esc"):
		#esc.emit()
	if event.is_action_pressed("slot_2"):
		use_item(1)

	if event.is_action_pressed("slot_3"):
		use_item(2)

	if event.is_action_pressed("slot_4"):
		use_item(3)

func _physics_process(delta: float) -> void:
	G.player_position = global_position
	var mouse_pos = get_global_mouse_position()
	var direction = global_position.angle_to_point(mouse_pos)
	$attack_area.global_rotation = direction
	if not dashing:
		velocity = Vector2.ZERO
		if Input.is_action_pressed("LKM"):
			if can_charge:
				if inf_stamina:
					charge += 0.0167
					stamina -= 0.0167
					
					_animation_update(direction)
				elif stamina >= 5:
					charge += 0.0167
					stamina -= 0.0167
					
					_animation_update(direction)
		elif Input.is_action_just_pressed("LKM"):
			attack_charging = true
		elif Input.is_action_just_released("LKM"):
			if inf_stamina:
				attack(direction)
			elif stamina >= 5:
				attack(direction)
		else:
			move()
	if Input.is_action_just_pressed("space"):
		if can_dash == true:
			if dash_cooldown == false:
				if inf_stamina:
					stamina -= 5
					stamina_changed.emit(stamina)
					dash()
				elif stamina >= 5:
					stamina -= 5
					stamina_changed.emit(stamina)
					dash()
	move_and_slide()

func move():
	var direction = Vector2(
		Input.get_action_strength("d") - Input.get_action_strength("a"),
		Input.get_action_strength("s") - Input.get_action_strength("w")
	)
	direction = direction.normalized()
	velocity = direction * speed
	_animation_update(direction)

func dash():
	var direction = Vector2(
		Input.get_action_strength("d") - Input.get_action_strength("a"),
		Input.get_action_strength("s") - Input.get_action_strength("w")
	)
	dashing = true
	if direction == Vector2.ZERO:
		direction = last_direction
	direction = direction.normalized()
	velocity = direction * 550
	await get_tree().create_timer(0.1).timeout
	dashing = false
	dash_cooldown = false

func attack(direction):
	var enemys = $attack_area.get_overlapping_bodies()
	if enemys.size() > 0:
		combo += 1
	for enemy in enemys:
		if enemy.has_method("take_damage"):
			var final_damage = damage * charge * (combo / 10)
			enemy.take_damage(final_damage)
	stamina -= 5
	charge = 1
	stamina_changed.emit(stamina)
	if direction >= -PI/4 and direction < PI / 4:
		player_sprite.play("attack_left")
		player_sprite.flip_h = true
	elif direction >= 3 * PI/4 or direction <= -3 * PI / 4:
		player_sprite.play("attack_left")
		player_sprite.flip_h = false
	elif direction >= -3 * PI/4 and direction < -PI / 4:
		player_sprite.play("attack_up")
		player_sprite.flip_h = false
	elif direction >= PI/4 and direction < 3 * PI / 4:
		player_sprite.play("attack_down")
		player_sprite.flip_h = false

func _on_combo_timeout() -> void:
	combo = 9

func _on_remainder_timer_timeout() -> void:
	G.time -= 0.05
	if stamina < max_stamina:
		stamina += 0.25

		
	if G.time == 500:

		can_dash = false
		max_hp = 90
		hp = hp * 90 / 100
		max_stamina = 95
		stamina = stamina * 95 / 100

	elif G.time == 400:

		can_combo = false
		max_hp = 80
		hp = hp * 80 / 100
		max_stamina = 90
		stamina = stamina * 90 / 100

	elif G.time == 300:

		can_charge = false
		max_hp = 70
		hp = hp * 70 / 100
		max_stamina = 85
		stamina = stamina * 85 / 100

		

	elif G.time == 200:

		max_hp = 60
		hp = hp * 60 / 100
		max_stamina = 80
		stamina = stamina * 80 / 100
		speed = 90

		


	elif G.time == 100:

		max_hp = 50
		hp = hp * 50 / 100
		max_stamina = 75
		stamina = stamina * 75 / 100
		speed = 80
	

func _on_dash_cooldown_timeout() -> void:
	dash_cooldown = false

func exit():
	if transition:
		call_deferred("set_collision_mask_value", 1, true)
		position = Vector2(320,332.0)
		await get_tree().physics_frame
		dashing = false
		can_dash = true
		transition = false
		visible = true
	else:
		call_deferred("set_collision_mask_value", 1, false)
		dashing = true
		can_dash = false
		transition = true
		visible = false
		velocity *= 0
		position = Vector2(320000,332000)


func infinity_stamina(count_down):
	inf_stamina_timer.start(count_down)
	inf_stamina = true

func _on_inf_stamina_timer_timeout() -> void:
	inf_stamina = false
		
func heal(amout):
	hp +=amout
	hp_changed.emit(hp)
	

	
func fireball_cast(damage_data):
	print("fire")
	var direction = (get_global_mouse_position() - global_position).normalized()

	var projectile: ProjectileAttack = projectile_attack.instantiate()
	projectile.global_position = global_position + direction * 60

	get_tree().current_scene.add_child(projectile)
	projectile.setup(damage_data, direction)

func alohomora_cast():
	G.emit_signal("enemys_end")

func _animation_update(direction):
	if typeof(direction) == TYPE_FLOAT:
		if direction >= -PI/4 and direction < PI / 4:
			player_sprite.play("charge_left")
			player_sprite.flip_h = true
			last_direction = Vector2.RIGHT
		elif direction >= 3 * PI/4 or direction <= -3 * PI / 4:
			player_sprite.play("charge_left")
			player_sprite.flip_h = false
			last_direction = Vector2.LEFT
		elif direction >= -3 * PI/4 and direction < -PI / 4:
			player_sprite.play("charge_up")
			player_sprite.flip_h = false
			last_direction = Vector2.UP
		elif direction >= PI/4 and direction < 3 * PI / 4:
			player_sprite.play("charge_down")
			player_sprite.flip_h = false
			last_direction = Vector2.DOWN
	else:
		if direction != Vector2.ZERO:
			last_direction = direction
			if last_direction.x > 0:
				player_sprite.flip_h = true
				player_sprite.play("walk_left")
			elif last_direction.x < 0:
				player_sprite.flip_h = false
				player_sprite.play("walk_left")
			elif last_direction.y < 0:
				player_sprite.flip_h = false
				player_sprite.play("walk_up")
			elif last_direction.y > 0:
				player_sprite.flip_h = false
				player_sprite.play("walk_down")
		elif direction == Vector2.ZERO:
			if last_direction.x > 0:
				player_sprite.flip_h = true
				player_sprite.play("idle_left")
			elif last_direction.x < 0:
				player_sprite.flip_h = false
				player_sprite.play("idle_left")
			elif last_direction.y < 0:
				player_sprite.flip_h = false
				player_sprite.play("idle_up")
			elif last_direction.y > 0:
				player_sprite.flip_h = false
				player_sprite.play("idle_down")

func take_damage(dmg):
	hp -= dmg
	hp_changed.emit(hp)
	if hp <= 0:
		daed.emit()
		#G.time = 600
		#G.room_finish = 1
