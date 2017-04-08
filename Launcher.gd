extends Node2D

var ball = preload("res://Ball.tscn")
export(int) var launch_pos = Vector2(1080/2, 1920/2)
var direction = Vector2(0, 0)
export(int) var balls = 1
export(int) var balls_to_shoot = 0
export(float) var shoot_delay = 0.05
var shoot_timer = 0

var input_start = Vector2(0, 0)
var input_end = Vector2(0, 0)
var input_dragging = false

onready var input_start_sprite = get_node("Sprite")
onready var direction_sprite = get_node("Sprite1")

func _ready():
	set_fixed_process(true)
	set_process_input(true)

func _fixed_process(delta):
	if balls_to_shoot > 0:
		shoot_timer += delta
		if shoot_timer > shoot_delay:
			shoot_timer -= shoot_delay
			shoot()
			balls_to_shoot -= 1
	else:
		shoot_timer = 0

func _input(event):
	if event.type == InputEvent.SCREEN_DRAG:
		input_dragging = true
		input_end = event.pos
	elif event.type == InputEvent.SCREEN_TOUCH:
		
		if input_dragging:
			input_end = event.pos
			balls_to_shoot = balls
		else:
			input_start = event.pos
			
		input_dragging = false
	
	direction = (input_end - input_start).normalized()
	update()
	
func _draw():
	if input_dragging:
		draw_line(input_start, input_end, Color(1, 1, 0, 1), 5)
	draw_line(launch_pos, launch_pos + direction*Vector2(100,100), Color(0, 1, 1, 1), 10)
	draw_circle(launch_pos, 10, Color(1, 0, 1, 1))

func shoot():
	var ball_node = ball.instance()
	ball_node.set_pos(launch_pos)
	ball_node.set_linear_velocity(direction * 1000)
	add_child(ball_node)