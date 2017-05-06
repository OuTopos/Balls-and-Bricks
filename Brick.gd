extends KinematicBody2D

export var hp = 11

onready var tween = get_node("Tween")

func _ready():
	refresh()

func hit():
	hp -= 1
	refresh()
	if hp <= 0:
		queue_free()
	

func refresh():
	get_node("HP").set_text(str(hp))

func move_down():
	tween.interpolate_property(self, "transform/pos", self.get_pos(), self.get_pos() + Vector2(0, 100), 0.5, Tween.TRANS_QUINT, Tween.EASE_OUT)
	tween.start() 