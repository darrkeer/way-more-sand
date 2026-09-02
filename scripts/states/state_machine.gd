extends Node
class_name StateMachine

@export var initial_state : String

var states = {}
var current_state : String = ""

func get_current_state() -> State:
	return states[current_state]

func change_state(state_name : String, options := {}) -> void:
	if state_name == current_state:
		return
	if state_name not in states:
		push_error("Unknown state: '%s'" % state_name)
	if current_state:
		states[current_state].exit()
	print(get_parent().name, " changed state to ", state_name)
	states[state_name].enter(options)
	current_state = state_name

func _ready() -> void:
	for child in get_children():
		if child is not State:
			push_error("Not state object in StateMachine children!")
			continue
		
		var st = child as State
		
		if st.state_name in states:
			push_error("Duplicate state of '%s'!" % st.state_name)
			continue
		states[st.state_name] = st
	
	change_state(initial_state)

func _physics_process(delta: float) -> void:
	get_current_state().fixed_update(delta)
