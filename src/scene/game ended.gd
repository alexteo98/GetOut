extends Node2D

var endScore = 0
var endTime = 0

func _ready():
	var totalScore = endScore - floor(endTime*10)
	$timeLbl.text = "Time Elasped: " + str(int(endTime)/60) + " Minutes " + str(int(endTime)%60) + " Seconds"
	$scoreLbl.text = "Score: " + str(totalScore)

func setScore(score):
	endScore = score

func setTime(time):
	endTime = time

func _on_TextureButton_pressed():
	get_tree().quit()
