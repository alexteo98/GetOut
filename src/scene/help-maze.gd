extends CanvasLayer

signal nextPageSnake

func _ready():
	pass 


func _on_TextureButton_pressed():
	emit_signal("nextPageSnake")
