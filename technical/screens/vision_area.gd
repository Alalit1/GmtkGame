extends Area2D
class_name VisionArea

var radius = 100
var target = null
@onready var shape = $CollisionShape2D.shape
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shape.radius = radius


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		target = body



func _on_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
