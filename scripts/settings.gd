extends Node

@export var values : Dictionary

signal settings_changed

func change_mouse_sens(value : float) -> void:
	change("mouse_sens", value)

func change_bgm_volume(value : float) -> void:
	change("bgm_volume", value)

func change_sfx_volume(value : float) -> void:
	change("sfx_volume", value)
	
func get_mouse_sens() -> float:
	return get_setting("mouse_sens")

func get_sfx_volume() -> float:
	return get_setting("sfx_volume")

func get_bgm_volume() -> float:
	return get_setting("bgm_volume")

func get_setting(setting_name : String):
	return values[setting_name]

func _ready() -> void:
	# fuck this shit
	# because in ready not everyone is subscribed yet
	# but they have to update sliders to default values
	GameController.create_one_shot_timeout(0.01).connect(func():
		settings_changed.emit()
	)

func change(setting_name : String, value) -> void:
	if setting_name not in values:
		push_error("counld not find such setting '%s'" % setting_name)
		return
	values[setting_name] = value
	settings_changed.emit()
