extends CanvasLayer

onready var pauseMenu = preload("res://src/scene/newPauseMenus.tscn")
var ref
var instNo = 0
var caller

func _ready():
	pass

func show(call):
	if instNo == 0:
		var inst = pauseMenu.instance()
		ref = inst
		caller = call
		get_parent().add_child(inst)
		inst.raise()
		instNo = 1

func close():
	caller.resume()
	get_parent().remove_child(ref)
	instNo = 0
