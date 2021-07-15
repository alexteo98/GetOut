extends Node2D

var endScore = 0

func _ready():
	$scoreLbl.text = "Score: " + str(endScore)

func setScore(score):
	endScore = score

func _on_TextureButton_pressed():
	get_tree().quit()
