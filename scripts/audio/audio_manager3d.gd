extends Node

const MAX_STREAMS_COUNT : int = 10

@export var sounds : Dictionary[String, AudioStream]
@export var audio_player_prefab : PackedScene

var streams : Array[AudioPlayer3D]

func _ready() -> void:
	Settings.settings_changed.connect(_on_settings_changed)
	while streams.size() < MAX_STREAMS_COUNT:
		var player := audio_player_prefab.instantiate() as AudioPlayer3D
		player.name += str(streams.size())
		add_child(player)
		streams.append(player)
	
	get_tree().scene_changed.connect(func():
		for s in streams:
			s.stop_sound()
	)

func _on_settings_changed() -> void:
	for s in streams:
		s.volume_linear = Settings.get_sfx_volume()

func play_sound_on_pos(pos : Vector3, sound_name : String) -> AudioPlayer3D:
	if sound_name not in sounds:
		push_error("can't find sound with name '%s'" % sound_name)
		return
	print("playing: ", sound_name)
	var sound := sounds[sound_name]
	for s in streams:
		if s.can_play:
			s.play_on_pos(pos, sound)
			return s
	push_error("polyphony overload")
	return null

func stop_sound(s : AudioPlayer3D) -> void:
	if s.can_play:
		push_error("he is not busy")
		return
	s.stop_sound()
