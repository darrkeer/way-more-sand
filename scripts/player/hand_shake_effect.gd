class_name HandShakeEffects
extends Node

const SHAKE_TIME = 0.2
const USE_TIME = 0.5

@export var state_machine : StateMachine

func _ready() -> void:
	GameController.shake_effects = self

func is_player_strafing() -> bool:
	var vel : Vector3 = GameController.player_body.velocity
	return vel.x != 0 or vel.z != 0

func make_use_effect() -> void:
	state_machine.change_state("use")
	GameController.create_one_shot_timeout(USE_TIME).connect(func():
		state_machine.change_state("idle")	
	)

func make_damage_effect() -> void:
	state_machine.change_state("damage")
	GameController.create_one_shot_timeout(SHAKE_TIME).connect(func():
		state_machine.change_state("idle")	
	)

func _process(_delta: float) -> void:
	if state_machine.current_state != "damage" and state_machine.current_state != "use":
		if is_player_strafing():
			state_machine.change_state("walk")
		else:
			state_machine.change_state("idle")
