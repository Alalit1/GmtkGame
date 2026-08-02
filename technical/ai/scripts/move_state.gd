class_name MoveState
extends State


var animation_player: AnimationPlayer


func _init(_owner: CharacterBody2D) -> void:
	super(_owner)

	animation_player = owner.get_node("AnimationPlayer")


func enter() -> void:
	animation_player.play("attack_up")


func exit() -> void:
	owner.velocity = Vector2.ZERO


func update(_delta: float) -> void:
	if action == null:
		return

	var direction := action.direction

	owner.velocity = direction * 100.0
	owner.move_and_slide()
