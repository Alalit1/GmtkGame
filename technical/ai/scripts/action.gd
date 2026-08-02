class_name Action
extends RefCounted


enum Type {
	IDLE,
	MOVE,
	ATTACK
}


var type: Type
var position: Vector2 = Vector2.ZERO
var target: Node2D = null
var direction: Vector2 = Vector2.ZERO

func _init(
	_type: Type = Type.IDLE,
	_position: Vector2 = Vector2.ZERO,
	_target: Node2D = null
) -> void:
	type = _type
	position = _position
	target = _target
