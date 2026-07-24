class_name Blackboard
extends RefCounted

var target: Node2D = null
var target_visible := false
var target_position := Vector2.ZERO

var last_known_position := Vector2.ZERO

var current_goal = ""
var current_state = ""
