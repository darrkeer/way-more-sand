extends StateWithSpriteAnimation

const ATTACK_DELAY_TIME : float = 1.2

@export var base : EnemyBase

func enter(options := {}) -> void:
	super(options)
	
	GameController.create_one_shot_timeout(ATTACK_DELAY_TIME).connect(func():
		state_machine.change_state("idle")
	)

func exit() -> void:
	super()
	
	if base.distance_to_player() < base.DAMAGE_RANGE and not base.just_damaged:
		GameController.clocks.decrease_time(base.BASE_DAMAGE)
	AudioManager3D.play_sound_on_pos(base.global_position, "knight_attack")
