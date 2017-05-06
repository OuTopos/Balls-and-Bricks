extends RigidBody2D

var ball = true

func _on_Ball_body_enter( body ):
	if body.has_method("hit"):
		body.hit()

func destroy():
	queue_free()