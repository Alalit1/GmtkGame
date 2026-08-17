extends Label

func _ready():
	var tween = create_tween()

	tween.set_parallel(true)

	# Політ вгору
	tween.tween_property(self, "position:y", position.y - 50, 1.0)

	# Плавне зникнення
	tween.tween_property(self, "modulate:a", 0.0, 1.0)

	await tween.finished
	queue_free()
