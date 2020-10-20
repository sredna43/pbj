# OnGround.gd, this is the state we use while we are
# touching a platform

extends "res://scripts/States/j/motion/motion.gd"

func handle_input(event):
    if event.is_action_pressed("pb_jump"):
        emit_signal("finished", "jump")
    return .handle_input(event)