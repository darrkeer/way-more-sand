extends StateWithSpriteAnimation

@export var base : EnemyBase

var last_player_pos : Vector3

func fixed_update(delta : float) -> void:
	super(delta)
	
	if base.distance_to_player() > base.INACTIVE_DISTANCE:
		state_machine.change_state("inactive")
		return
	
	if base.can_attack_player():
		state_machine.change_state("attack")
		return
	
	if base.can_see_player():
		last_player_pos = GameController.player_body.global_position
	
	base.agent.target_position = last_player_pos
	
	base.move_to_target()
	base.move_and_slide()
