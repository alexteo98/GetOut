extends CanvasLayer

onready var pauseMenu = preload("res://src/scene/newPauseMenus.tscn")
var ref
var instNo = 0

func _ready():
	pass

func show():
	if instNo == 0:
		var inst = pauseMenu.instance()
		ref = inst
		get_parent().add_child(inst)
		inst.raise()
		instNo = 1

func close():
	get_parent().remove_child(ref)
	instNo = 0
