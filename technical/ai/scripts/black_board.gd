class_name Blackboard
extends RefCounted

var target: Node2D = null

var target_position := Vector2.ZERO

var global_position : Vector2

var attack_type : String = "melee"
var attack_range := 30.0
var distance
var long_range_attack_distance := 70.0

var current_state = ""
