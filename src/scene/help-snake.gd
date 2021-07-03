extends CanvasLayer

signal nextPageFlappy

func _ready():
	pass




func _on_TextureButton_pressed():
	emit_signal("nextPageFlappy")
