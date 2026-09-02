class_name KnifeResource
extends ItemResource

const CLICK_COOLDOWN = 0.5

@export var DAMAGE : int

var knife_ready = true

func _get_random_swing_sound() -> String:
	return "knife_hit" + str(randi_range(1, 3))

func use() -> void:
	if not knife_ready:
		return
	knife_ready = false
	GameController.create_one_shot_timeout(CLICK_COOLDOWN).connect(func():
		knife_ready = true
	)
	
	AudioManager3D.play_sound_on_pos(GameController.player_body.global_position, _get_random_swing_sound())
	var col = GameController.interactor.raycast.get_collider()
	if col:
		print(col.name)
	if col and col is EnemyBase:
		var enemy := col as EnemyBase
		enemy.get_damage(DAMAGE)
