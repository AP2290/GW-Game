extends Node2D

func _ready() -> void:
	position = Vector2(115,415)
	
func _process(delta: float) -> void:
	position += Vector2(1,0) * 80 * delta
