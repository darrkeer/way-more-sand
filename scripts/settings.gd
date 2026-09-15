extends Node

signal settings_changed

func set_mouse_sens(value : float) -> void:
	SaveManager.save_data.MOUSE_SENS = value
	settings_changed.emit()

func set_bgm_volume(value : float) -> void:
	SaveManager.save_data.BGM_VOLUME = value
	settings_changed.emit()

func set_sfx_volume(value : float) -> void:
	SaveManager.save_data.SFX_VOLUME = value
	settings_changed.emit()

func set_player_move_speed(value : float) -> void:
	SaveManager.save_data.PLAYER_MOVE_SPEED = value
	settings_changed.emit()

func set_max_time(value : int) -> void:
	SaveManager.save_data.MAX_TIME = value
	settings_changed.emit()

func get_mouse_sens() -> float:
	return SaveManager.save_data.MOUSE_SENS

func get_sfx_volume() -> float:
	return SaveManager.save_data.SFX_VOLUME

func get_player_move_speed() -> float:
	return SaveManager.save_data.PLAYER_MOVE_SPEED

func get_max_time() -> int:
	return SaveManager.save_data.MAX_TIME

func get_bgm_volume() -> float:
	return SaveManager.save_data.BGM_VOLUME

func get_setting(setting_name : String):
	return SaveManager.save_data.get(setting_name)

func _ready() -> void:
	# fuck this shit
	# because in ready not everyone is subscribed yet
	# but they have to update sliders to default values
	GameController.create_one_shot_timeout(0.01).connect(func():
		settings_changed.emit()
	)

func change(setting_name : String, value) -> void:
	if setting_name not in SaveManager.save_data:
		push_error("counld not find such setting '%s'" % setting_name)
		return
	SaveManager.save_data.set(setting_name, value)
	settings_changed.emit()
