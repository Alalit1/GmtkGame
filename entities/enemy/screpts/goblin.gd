extends BaseEnemy

@export var damage_data : DamageData 
@export var damage_area: PackedScene
@onready var timer: Timer = $Timer
var amount_attack = 0
var bullet: Node

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
	else:
		
		var direction = global_position.direction_to(vision.target.global_position)
		velocity = direction * enemy_data.speed
	
	move_and_slide()

func attack(damage_data:DamageData, direction, pos: Vector2):
	if is_instance_valid(bullet):
		return

	timer.start()

	bullet = damage_area.instantiate() # без var
	bullet.global_position = pos
	bullet.damage_data = damage_data

	get_tree().current_scene.add_child(bullet)
	#amount_attack += 1
	


func _on_timer_timeout() -> void:
	if is_instance_valid(bullet):
		bullet.queue_free()
		bullet = null
	#amount_attack -= 1
