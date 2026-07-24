class_name DamageZone
extends Area2D

@export var damage_data: DamageData

var targets: Array[Node] = []


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node) -> void:
	if body.has_method("take_damage"):
		targets.append(body)


func _on_body_exited(body: Node) -> void:
	if body in targets:
		targets.erase(body)


func apply_damage() -> void:
	var damage := Damage.new()

	for target in targets:
		damage.apply(damage_data, target)
