extends BaseEnemy

@export var damage_data : DamageData 
@export var damage_area: PackedScene
@onready var timer: Timer = $Timer
@onready var sprite = $AnimatedSprite2D
var amount_attack = 0
var bullet: Node
var health 
func _ready() -> void:
	health = enemy_data.health

func _physics_process(_delta):
	if vision.target == null:
		
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var distance = global_position.distance_to(vision.target.global_position)
	var target_point : Vector2= vision.target.global_position + vision.target.global_position.direction_to(global_position) * 15
	#print(target_point,vision.target.global_position.direction_to(global_position) * 40)
	if distance <= 40:
		velocity = Vector2.ZERO
		if !is_instance_valid(bullet):
			attack(damage_data, distance,target_point)
			var direction = global_position.angle_to_point(vision.target.global_position)
			if direction >= -PI/4 and direction < PI / 4:
				sprite.play("attack_left")
				sprite.flip_h = true
			elif direction >= 3 * PI/4 or direction <= -3 * PI / 4:
				sprite.play("attack_left")
				sprite.flip_h = false
			elif direction >= -3 * PI/4 and direction < -PI / 4:
				sprite.play("attack_up")
				sprite.flip_h = false
			elif direction >= PI/4 and direction < 3 * PI / 4:
				sprite.play("attack_down")
				sprite.flip_h = false
	else:
		
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

func take_damage(amout):
	health = -amout
	if health <= 0 :
		self.queue_free()
		G.emit_signal("enemy_dead", spawn_position)

func attack(damage_data:DamageData, direction, pos: Vector2):
	if is_instance_valid(bullet):
		return

	timer.start()

	bullet = damage_area.instantiate() # без var
	bullet.global_position = pos
	bullet.damage_data = damage_data

	bullet.tree_exited.connect(_on_bullet_removed)

	get_tree().current_scene.add_child(bullet)
	
func _on_bullet_removed():
	bullet = null

func _on_timer_timeout() -> void:
	print("Timer timeout")

	if is_instance_valid(bullet):
		bullet.queue_free()
	#amount_attack -= 1
