extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var game = get_node("../")

func _ready():
	pass

func _on_Ball_body_enter( body ):
	if body.has_method("hit"):
		body.hit()
