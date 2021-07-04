extends Area2D

signal startMinigame

onready var snake = preload("res://src/scene/level.tscn")

func _ready():
	pass 

func _on_snakeminigame_body_entered(body):
	if body.name == "Player":
		get_parent().remove_child(self)
		emit_signal("startMinigame")
