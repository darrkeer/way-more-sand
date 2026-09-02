extends StateWithSpriteAnimation

const DAMAGE_WAIT_TIME : float = 0.5
const BLINK_TIME : float = 0.1

@export var base : EnemyBase
@export var sprite : AnimatedSprite3D

func enter(options := {}) -> void:
	super(options)
	
	AudioManager3D.play_sound_on_pos(base.global_position, "knight_damage")
	GameController.create_one_shot_timeout(DAMAGE_WAIT_TIME).connect(func():
		state_machine.change_state("idle")	
	)
	
	var t := get_tree().create_tween()
	t.tween_property(sprite, "modulate", Color.RED, BLINK_TIME)
	t.finished.connect(func():
		var tt := get_tree().create_tween()
		tt.tween_property(sprite, "modulate", Color.WHITE, BLINK_TIME)
	)


func fixed_update(_delta : float) -> void:
	if base.hp <= 0:
		state_machine.change_state("death")
