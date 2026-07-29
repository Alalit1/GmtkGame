extends BaseEnemy

@export var damage_data : DamageData 
@export var damage_area: PackedScene
@onready var timer: Timer = $Timer
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
	if !is_instance_valid(bullet):
			attack(damage_data, directione,attack_position)
		
	var direction = global_position.direction_to(vision.target.global_position)
	velocity = direction * enemy_data.speed
	
	move_and_slide()

func attack(damage_data:DamageData, direction, pos: Vector2):
	if is_instance_valid(bullet):
		return
	bullet = damage_area.instantiate()
	bullet.tree_exited.connect(_on_bullet_destroyed)
	timer.start()
	

	get_tree().current_scene.add_child(bullet)

	bullet.global_position = pos
	bullet.setup(damage_data, direction)

	
	#get_tree().current_scene.add_child(bullet)
	"""bullet = damage_area.instantiate() # без var
	bullet.global_position = pos
	bullet.damage_data = damage_data

	get_tree().current_scene.add_child(bullet)"""
	#amount_attack += 1
	
func take_damage(amout):
	health = -amout
	if health <= 0 :
		self.queue_free()

func _on_bullet_destroyed():
	bullet = null

func _on_timer_timeout() -> void:
	if is_instance_valid(bullet):
		bullet.queue_free()
		bullet = null
	#damage_area.queue_free()
