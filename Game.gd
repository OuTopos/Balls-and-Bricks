extends Node2D


var ball = preload("res://Ball.tscn")
var brick = preload("res://Brick.tscn")

export(int) var launch_pos = Vector2(1080/2, 1920/2+500)
var direction = Vector2(0, 0)
export(int) var balls = 1
export(int) var balls_to_shoot = 0
export(float) var shoot_delay = 0.05
var shoot_timer = 0

var input_start = Vector2(0, 0)
var input_end = Vector2(0, 0)
var input_dragging = false

var state = "ready"
var spawn_point_set = true
var balls_destroyed = 0

var level = 0

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	state_ready()

func _fixed_process(delta):
	if balls_to_shoot > 0:
		shoot_timer += delta
		if shoot_timer > shoot_delay:
			shoot_timer -= shoot_delay
			shoot()
			balls_to_shoot -= 1
			print(balls_to_shoot)
	else:
		shoot_timer = 0

func _input(event):
	if state == "ready":
		if event.type == InputEvent.SCREEN_DRAG:
			input_dragging = true
			input_end = event.pos
		elif event.type == InputEvent.SCREEN_TOUCH:
			
			if input_dragging:
				input_end = event.pos
				state_shooting()
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
func spawn_bricks():
	for i in range(6):
		randomize()
		if bool(randi()%2):
			var brick_node = brick.instance()
			brick_node.set_pos(Vector2(i * 180, 0))
			add_child(brick_node)
	get_tree().call_group(0, "Bricks", "move_down")
	
func state_ready():
	state = "ready"
	level += 1
	spawn_bricks()
	balls_destroyed = 0
	balls += 1

func state_shooting():
	state = "shooting"
	balls_to_shoot = balls
	spawn_point_set = false


# SIGNALS
func _on_Ball_body_enter( body ):
	print("asdasd BODY")

func _on_Spawn_Area_body_enter( body ):
	if body.get("ball"):
		if not spawn_point_set:
			launch_pos.x = body.get_pos().x
			spawn_point_set = true


func _on_Destroy_Area_body_enter( body ):
	if body.get("ball"):
		balls_destroyed += 1
		if balls_destroyed == balls:
			state_ready()