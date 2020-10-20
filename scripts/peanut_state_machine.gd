# PlayerStateMachine.gd, used for both players.
# This is the actual state machine that uses all of the states
# and changes them for the player.

extends "res://scripts/SMVirtuals/state_machine.gd"

onready var idle = $Idle
onready var move = $Move
onready var jump = $Jump
onready var double_jump = $DoubleJump
onready var die = $Die
onready var attack = $Attack

# States that can't be interrupted by an attack
var no_attack_interrupt = [attack, double_jump]

func _ready():
    states_map = {
        "idle": idle,
        "move": move,
        "jump": jump,
        "double_jump": double_jump,
        "die": die,
        "attack": attack,
    }

func _change_state(state_name):
    if not _active:
        return
    if state_name in ["jump", "attack"]:
        states_stack.push_front(states_map[state_name])
    if state_name == "jump" and current_state == move:
        jump.initialize(move.speed, move.velocity)
    ._change_state(state_name)

# Only handle the input that can interrupt states (attack)
func _unhandled_input(event):
    if event.is_action_pressed("pb_attack"):
        if current_state in no_attack_interrupt:
            return
        _change_state("attack")
        return
    current_state.handle_input(event)