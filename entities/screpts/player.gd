extends CharacterBody2D

@export var speed := 100.0
@export var max_hp := 100.0
@export var hp := 100.0
@export var damage := 20.0
@export var stamina := 100.0
@export var max_stamina := 100.0
var dash_cooldown := false
var dashing := false
var last_direction := Vector2(1,0)
var attack_charging := false
var charge := 1.0
var combo := 9.0
var can_dash = true
var can_charge = true
var can_combo = true

func _physics_process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	var direction = global_position.angle_to_point(mouse_pos)
	$attack_area.global_rotation = direction
	if not dashing:
		move()
		if Input.is_action_pressed("LKM"):
			if can_charge:
				if stamina >= 5:
					charge += 0.0167
					stamina -= 0.0167
		if Input.is_action_just_pressed("LKM"):
			attack_charging = true
		if Input.is_action_just_released("LKM"):
			if stamina >= 5:
				attack()
			attack_charging = false
	if Input.is_action_just_pressed("space"):
		if can_dash == true:
			if dash_cooldown == false:
				if stamina >= 5:
					stamina -= 5
					dash()
	move_and_slide()

func move():
	var direction = Vector2(
		Input.get_action_strength("d") - Input.get_action_strength("a"),
		Input.get_action_strength("s") - Input.get_action_strength("w")
	)
	if direction != Vector2.ZERO:
		last_direction = direction
	direction = direction.normalized()
	velocity = direction * speed

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

func attack():
	var enemys = $attack_area.get_overlapping_bodies()
	if enemys.size() > 0:
		combo += 1
	for enemy in enemys:
		var final_damage = damage * charge * (combo / 10)
		enemy.take_damage(final_damage)
	stamina -= 5
	charge = 1

func _on_combo_timeout() -> void:
	combo = 9

func _on_remainder_timer_timeout() -> void:
	g.time -= 0.05
	if stamina < max_stamina:
		stamina += 0.25
	if g.time == 100:
		can_dash = false
		max_hp = 90
		hp = hp * 90 / 100
		max_stamina = 95
		stamina = stamina * 95 / 100
	elif g.time == 80:
		can_combo = false
		max_hp = 80
		hp = hp * 80 / 100
		max_stamina = 90
		stamina = stamina * 90 / 100
	elif g.time == 60:
		can_charge = false
		max_hp = 70
		hp = hp * 70 / 100
		max_stamina = 85
		stamina = stamina * 85 / 100
	elif g.time == 60:
		max_hp = 60
		hp = hp * 60 / 100
		max_stamina = 80
		stamina = stamina * 80 / 100
		speed = 90
	elif g.time == 40:
		max_hp = 50
		hp = hp * 50 / 100
		max_stamina = 75
		stamina = stamina * 75 / 100
		speed = 80
	elif g.time == 20:
		max_hp = 40
		hp = hp * 40 / 100
		max_stamina = 70
		stamina = stamina * 70 / 100
		speed = 70

func _on_dash_cooldown_timeout() -> void:
	dash_cooldown = false
