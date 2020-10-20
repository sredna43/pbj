# StateMachine.gd, virtual class that handles the changing of states.
# Initializes, sets active or not, changes current/active state, holds stack.
# _physics_process and input handling are mostly left up to the States.

extends Node

# Some states may want to know
signal state_changed(current_state)

# To be set in editor, if not, _ready() sets it... See below.
export (NodePath) var start_state

# This will be a mapping from State name to the state's node name
var states_map = {}
var states_stack = []
var current_state = null
# Is this node currently active in the scene?
var _active = false setget set_active

func _ready() -> void:
    # If it hasn't been given, take the first state in the
    # State machine's children states. ie. PlayerStateMachine.tscn 
    # has Idle.tscn as its first child.
    if not start_state:
        start_state = get_child(0).get_path()
    # Connect to all of the possible states that this machine is
    # capable of handling.
    for child in get_children():
        # Connect the "finsihed" signal from States to the "_change_state" function below
        var err = child.connect("finished", self, "_change_state")
        if  err:
            printerr(err)
    initialize(start_state)

func initialize(initial_state) -> void:
    set_active(true)
    # push the start_state to the stack to be kept track of
    states_stack.push_front(get_node(initial_state))
    current_state = states_stack[0]
    current_state.enter()

func _change_state(state_name) -> void:
    if not _active:
        return
    # Tell the current state to tear down
    current_state.exit()
    
    # States send a "previous" signal after they're finished
    if state_name == "previous":
        states_stack.pop_front()
    else:
        states_stack[0] = states_map[state_name]
    
    current_state = states_stack[0]
    emit_signal("state_changed", current_state)

    if state_name != "previous":
        current_state.enter()

func set_active(is_active) -> void:
    _active = is_active
    set_physics_process(_active)
    set_process_input(_active)
    if not _active:
        states_stack = []
        current_state = null

func _unhandled_input(event) -> void:
    current_state.handle_input(event)

func _physics_process(delta: float) -> void:
    current_state.update_state(delta)

# This needs to be connected to the animation player
func _on_amination_finished(animation_name) -> void:
    if not _active:
        return
    current_state._on_amination_finished(animation_name)
