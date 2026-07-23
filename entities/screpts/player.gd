extends CharacterBody2D

@export var player_speed = 250
@export var player_hp = 100
@export var player_attack = 10
var dash_cooldown = false
var dashing = false
var last_direction = Vector2(1,0)
var attack_charging = false

func _physics_process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	var direction = global_position.angle_to_point(mouse_pos)
	$attack_area.global_rotation = direction
	if not dashing:
		move()
		if Input.is_action_just_pressed("LKM"):
			attack()
		if Input.is_action_pressed("LKM"):
			pass
		if Input.is_action_just_released("LKM"):
			attack()
	if Input.is_action_just_pressed("shift"):
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
	velocity = direction * player_speed

func dash():
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	dashing = true
	if direction == Vector2.ZERO:
		direction = last_direction
	direction = direction.normalized()
	velocity = direction * 1000
	await get_tree().create_timer(0.1).timeout
	dashing = false

func attack():
	for enemy in $attack_area.get_overlapping_bodies():
		enemy.take_damage()
