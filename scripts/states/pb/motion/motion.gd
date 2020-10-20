# Motion.gd, handles the direction and animation of the player
extends "res://scripts/SMVirtuals/state.gd"

# Max speed, defined in editor
export (float) var max_speed = 800.0

# Define some speed and velocity so we know where to move!
var speed = 0.0
var velocity = Vector2()
const UP = Vector2.UP

# This may or may not need to be used, but would halt all motion
func handle_input(_event):
    pass

func get_input_direction():
    return Input.get_action_strength("pb_right") - Input.get_action_strength("pb_left")

func update_look_direction(dir):
    if dir and owner.look_direction != dir:
        owner.look_direction = dir

func move(_delta, _speed, _direction: Vector2):
    velocity = _direction.normalized() * _speed
