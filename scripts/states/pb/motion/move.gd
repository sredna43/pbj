# Move.gd, controls actually moving the player

extends "res://scripts/states/pb/motion/motion.gd"


func enter():
    speed = 0.0
    velocity = Vector2()

    var input_direction = get_input_direction()
    update_look_direction(input_direction)
    # owner.get_node("AnimationPlayer").play("walk")


func handle_input(event):
    return .handle_input(event)


func update(_delta):
    var input_direction = get_input_direction()
    if not input_direction:
        emit_signal("finished", "idle")
    update_look_direction(input_direction)

    speed = max_speed
    var collision_info = move(_delta, speed, )