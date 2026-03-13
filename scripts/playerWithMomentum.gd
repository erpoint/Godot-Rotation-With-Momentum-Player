extends CharacterBody2D

var input_up_down : float
var input_left_right : float

@onready var rotation_accel = 0
@onready var rotation_smoother = 0
@onready var t_smoother = 0
@onready var last_roatation_sign = 0

@export var max_speed=400
@export var accel = 0
@export var friction = 600
@export var rotation_speed = 1.5
@export_range(0.01, 0.1, 0.01) var rotation_smoothness = .1


## Compute axis for the new direction
func get_axis():
	input_left_right = Input.get_axis("move_left", "move_right")
	input_up_down = Input.get_axis("move_up", "move_down")
	if input_left_right != 0:
		last_roatation_sign = input_left_right
	velocity += transform.y * input_up_down * accel

## Get directional input from keyboard
func get_input():
	
	# No need to care about left and right movements since 
	# this project use rotationals movments
	var input_direction = Input.get_vector("no_need", "no_need", "move_up", "move_down")
	return input_direction.normalized()

## Process the positional momentum using [friction] to slow down the
## movement once the player realed the keys
##
## [delta] : time passed since the last frame
func process_momentum(delta: float):
	if velocity.length() > (friction*delta) :
		if accel > 0:
			accel -= 1
		velocity -= velocity.normalized() * (friction * delta)
	else :
		velocity = Vector2.ZERO
		accel = 0

## Process the rotational momentum using lerp with [rotation_smoothness] 
## once the player released the keys
##
## [delta] : time passed since the last frame
func process_rotation_momentum(delta: float):
		t_smoother += rotation_smoothness
		rotation_smoother = lerp(1.0, 0.0, clamp(t_smoother, 0, 1))
		rotation += (input_left_right + rotation_smoother*last_roatation_sign) * rotation_speed * delta

## Rotate the CharaterBody2D depending on [rotation_speed] and
## custom implementation of acceleration (not phyisicly based)
##
## [delta] : time passed since the last frame
func rotate_with_acceleration(delta: float):
	rotation_accel = min(rotation_accel + .1, 2)
	rotation += input_left_right * (rotation_speed + rotation_accel) * delta
	t_smoother = 0



## Move the player position 
##
## [input] input from the keyboard (generaly from Input.get_vector())
## [delta] : time passed since the last frame
func accelerate(input: Vector2, delta: float):
	accel = min(accel +  1, 1500)
	velocity += (input * accel * delta)
	velocity = velocity.limit_length(max_speed)
	t_smoother = 1

## Handle the movement of the player
##
## [delta] : time passed since the last frame
func player_movement(delta : float):
	var input = get_input()
	get_axis()
		
	if input == Vector2.ZERO :
		if input_left_right == 0:
			process_rotation_momentum(delta)
		process_momentum(delta)
	else :
		accelerate(input, delta)
	if input_left_right != 0:
		rotate_with_acceleration(delta)
	move_and_slide()
	
func _physics_process(delta):
	player_movement(delta)
