extends Area2D

@onready var warning = $Sprite2D
@onready var sprite = $AnimatedSprite2D

var dmg = 10

func _ready() -> void:
	await create_tween().tween_property(warning, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.6).finished
	sprite.visible = true
	sprite.play("default")
	warning.visible = false

func _on_animated_sprite_2d_animation_finished() -> void:
	for player in get_overlapping_bodies():
		if player != null:
			player.take_damage(dmg)
	await create_tween().tween_property(sprite, "modulate", Color(1.0, 1.0, 1.0, 0.0), 0.25).finished
	queue_free()
