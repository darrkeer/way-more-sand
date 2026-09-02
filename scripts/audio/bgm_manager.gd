extends Node

@export var sounds : Dictionary[String, AudioStream]
@export var player : AudioStreamPlayer

func _ready() -> void:
	Settings.settings_changed.connect(_on_settings_changed)
	play("bgm1")

func _on_settings_changed() -> void:
	player.volume_linear = Settings.get_bgm_volume()

func play(sound_name : String) -> void:
	if sound_name not in sounds:
		push_error("can't find sound with name '%s'" % sound_name)
		return
	player.stream = sounds[sound_name]
	player.play()
