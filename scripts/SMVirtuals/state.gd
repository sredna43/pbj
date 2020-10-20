# CharacterState.gd class definition for character states, virtual class

extends Node

# warning-ignore:unused_signal
signal finished(next_state_name)

# Initializer
func enter() -> void:
    pass

# Clean up
func exit() -> void:
    pass

func handle_input(_event) -> void:
    pass

func update_state(_delta) -> void:
    pass

# Most likely where we will emit the "finished" signal
func _on_animation_finished(_animation_name):
    pass