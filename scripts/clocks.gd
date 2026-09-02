class_name Clocks
extends Node

@export var stats : PlayerStats

@export var progress_bar : TextureProgressBar

var time_left : int

func add_time(amount : int) -> void:
	time_left = clamp(time_left + amount, 0, stats.MAX_TIME)
	_update_bar()

func decrease_time(amount : int) -> void:
	time_left = max(0, time_left - amount)
	_update_bar()
	AudioManager3D.play_sound_on_pos(GameController.player_body.global_position, "damage")
	GameController.shake_effects.make_damage_effect()

func _update_bar() -> void:
	progress_bar.value = time_left

func _ready() -> void:
	GameController.clocks = self
	GameController.create_repeat_timeout(1).connect(_on_timeout)
	time_left = stats.BASE_TIME
	progress_bar.max_value = stats.MAX_TIME

func get_random_clock_sound() -> String:
	return "clock" + str(randi_range(1, 4))

func _on_timeout() -> void:
	time_left -= 1
	AudioManager3D.play_sound_on_pos(
		GameController.player_body.global_position,
		get_random_clock_sound()
	)
	_update_bar()
	if time_left <= 0:
		SceneManager.restart_scene()
