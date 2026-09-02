extends Slider

@export var setting_name : String

func _update_val() -> void:
	value = Settings.get_setting(setting_name)

func _ready() -> void:
	value_changed.connect(func(val):
		Settings.change(setting_name, val)
	)
	Settings.settings_changed.connect(func():
		_update_val() 
	)
	_update_val()
