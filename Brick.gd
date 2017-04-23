extends KinematicBody2D

export var hp = 10

func _ready():
	refresh()

func hit():
	hp -= 1
	refresh()
	if hp <= 0:
		queue_free()
	

func refresh():
	get_node("HP").set_text(str(hp))