# Attack.gd, handles when a player is attacking and cannot do anything else

extends "res://scripts/SMVirtuals/state.gd" 

func handle_input(event):
	if event.is_action_pressed("pb_attack"):
		emit_signal("finished", "attack")
