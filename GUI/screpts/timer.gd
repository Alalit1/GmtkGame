extends Control

@onready var label: Label = $Panel/Label
# Called when the node enters the scene tree for the first time.

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	
	label.text = str(int(TimeGlobal.time))
