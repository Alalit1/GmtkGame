extends CharacterBody2D
class_name Player


signal hp_changeds(new_hp)
signal stamina_changed(new_stamina)
signal daed()
signal esc()
var inventore = []

@export var player_data : PlayerData




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


@onready var player_animator = $AnimationPlayer
@onready var player_sprite = $AnimatedSprite2D
@onready var player_sounds = $AudioStreamPlayer2D
@onready var ui = $CanvasLayer/PlayerUI
@onready var component = $Component


func _ready() -> void:
	component.setup(player_data)
	$Component/HealthComponent.hp_changed.connect(_on_hp_changed)
	$Component/HealthComponent.daed.connect(_on_daed)
	# установка столкновений
	$CollisionShape2D.shape.radius = player_data.radius - 20
	$CollisionShape2D.shape.height = player_data.height -20
	
		
func _on_daed():
	daed.emit()


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
	if event.is_action_pressed("Esc"):
		esc.emit()
		
	if event.is_action_pressed("slot_1"):
		use_item(0)
	
	if event.is_action_pressed("slot_2"):
		use_item(1)

	if event.is_action_pressed("slot_3"):
		use_item(2)

	if event.is_action_pressed("slot_4"):
		use_item(3)


func _on_hp_changed(amout):
	print("test take dm _____",amout)
	hp_changeds.emit(amout)


"""func _physics_process(delta: float) -> void:
	G.player_position = global_position
	var mouse_pos = get_global_mouse_position()
	var direction = global_position.direction_to(mouse_pos)
	
	if not dashing:
		velocity = Vector2.ZERO
		if Input.is_action_pressed("LKM"):
			if can_charge:
				if inf_stamina:
					charge += 0.0167
				
				elif stamina >= 5:
					charge += 0.0167
					stamina -= 0.167
					
			
		elif Input.is_action_just_pressed("LKM"):
			attack_charging = true
		elif Input.is_action_just_released("LKM"):
			if inf_stamina:
			
				attack(direction)
			elif stamina >= 5:
				attack(direction)
				stamina -= 5
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
	move_and_slide()"""

func move():
	var direction = Vector2(
		Input.get_action_strength("d") - Input.get_action_strength("a"),
		Input.get_action_strength("s") - Input.get_action_strength("w")
	)
	direction = direction.normalized()
	velocity = direction * player_data.speed


func dash():
	var direction = Vector2(
		Input.get_action_strength("d") - Input.get_action_strength("a"),
		Input.get_action_strength("s") - Input.get_action_strength("w")
	)
	dashing = true
	if direction == Vector2.ZERO:
		direction = last_direction
	direction = direction.normalized()
	velocity = direction * player_data.speed_up
	await get_tree().create_timer(0.1).timeout
	dashing = false
	dash_cooldown = false

func attack(direction: Vector2) -> void:
	var attack_pos := global_position + direction * 20
	

	$Component/AttackComponent.attack(
		player_data.damage_data,
		direction,
		attack_pos
	)
	#await get_tree().create_timer(attack_cooldown).timeout
	

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
