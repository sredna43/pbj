# Jumping.gd, handles the jumping state of our character

extends "res://scripts/states/pb/motion/motion.gd"

export (float) var jump_accel = 2000.0
export (float) var gravity = 2000.0
export (float) var jump_power = 800.0

var enter_velocity = Vector2()

var horizontal_speed = 0.0
var horizontal_velocity = Vector2()

var vertical_speed = 0.0
var height = 0.0

func initialize(speed, velocity):
    horizontal_speed = speed
    enter_velocity = velocity

func enter():
    var input_direction = get_input_direction()
    update_look_direction(input_direction)
    horizontal_velocity = enter_velocity if input_direction else Vector2()
    vertical_speed = jump_power
    # owner.get_node("AnimationPlayer").play("jump")

func update(delta):
    var input_direction = get_input_direction()
    update_look_direction(input_direction)
    move(delta, speed, input_direction)