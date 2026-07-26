extends BaseEnemy

@export var damage_data : DamageData 
@export var damage_area: PackedScene
@onready var timer: Timer = $Timer
@onready var sprite = $AnimatedSprite2D
var health = 10
var amount_attack = 0
var bullet: Node
"""
if vision.target == null:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var direction = global_position.direction_to(vision.target.global_position)

	velocity = direction * current_speed
	move_and_slide()
"""

func _physics_process(_delta):
	if vision.target == null:
		
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var directione = global_position.direction_to(vision.target.global_position)
	#var target_point : Vector2= vision.target.global_position + vision.target.global_position.direction_to(global_position) * 15
	var attack_position = global_position + directione * 25
	#print(target_point,vision.target.global_position.direction_to(global_position) * 40)
	#if !is_instance_valid(bullet):
			#attack(damage_data, directione,attack_position)
		
	var direction = global_position.direction_to(vision.target.global_position)
	velocity = direction * enemy_data.speed
	
	direction = global_position.angle_to_point(vision.target.global_position)
	if direction >= -PI/4 and direction < PI / 4:
		sprite.play("walk_left")
		sprite.flip_h = true
	elif direction >= 3 * PI/4 or direction <= -3 * PI / 4:
		sprite.play("walk_left")
		sprite.flip_h = false
	elif direction >= -3 * PI/4 and direction < -PI / 4:
		sprite.play("walk_up")
		sprite.flip_h = false
	elif direction >= PI/4 and direction < 3 * PI / 4:
		sprite.play("walk_down")
		sprite.flip_h = false
	move_and_slide()

func attack(damage_data:DamageData, direction, pos: Vector2):
	if is_instance_valid(bullet):
		return
	
	timer.start()
	var directione = global_position.direction_to(vision.target.global_position)

	bullet = damage_area.instantiate()
	#bullet.global_position = global_position + directione * 10
	#bullet.damage_data = damage_data
	bullet.setup(damage_data, directione)
	bullet.global_position = pos
	bullet.damage_data = damage_data
	#add_child(bullet)
	get_tree().current_scene.add_child(bullet)
	"""bullet = damage_area.instantiate() # без var
	bullet.global_position = pos
	bullet.damage_data = damage_data

	get_tree().current_scene.add_child(bullet)"""
	#amount_attack += 1
	
func take_damage(amout):
	health = -amout
	if health <= 0 :
		self.queue_free()
		G.emit_signal("enemy_dead", spawn_position)

func _on_timer_timeout() -> void:
	if is_instance_valid(bullet):
		bullet.queue_free()
		bullet = null
	#damage_area.queue_free()
