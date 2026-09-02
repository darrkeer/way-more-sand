extends Node
class_name State

@export var state_name : String

var state_machine : StateMachine
var is_in_state = false

func _ready() -> void:
	var p = get_parent()
	if not p or p is not StateMachine:
		return
	state_machine = p as StateMachine

func enter(_options := {}) -> void:
	is_in_state = true

func exit() -> void:
	is_in_state = false

func fixed_update(_delta : float) -> void:
	pass
