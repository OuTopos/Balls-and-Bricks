extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass

func _body_enter(body):
	print("asdasd BODY")

func poop( body ):
	body.hit()
	print("poop")
