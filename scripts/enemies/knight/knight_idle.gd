extends StateWithSpriteAnimation

@export var base : EnemyBase

func fixed_update(delta : float) -> void:
	super(delta)
	
	print("active")
	if base.distance_to_player() > base.INACTIVE_DISTANCE:
		state_machine.change_state("inactive")
		return
	
	if base.can_see_player():
		print("can see")
		state_machine.change_state("chase")
