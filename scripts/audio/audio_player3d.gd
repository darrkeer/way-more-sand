class_name AudioPlayer3D
extends AudioStreamPlayer3D

var can_play : bool = true

func _ready() -> void:
	finished.connect(func() -> void:
		can_play = true
	)

#func can_play() -> bool:
	#return playing_sound == ""

func stop_sound() -> void:
	can_play = true
	stop()

func play_on_pos(pos : Vector3, sound : AudioStream) -> void:
	global_position = pos
	stream = sound
	can_play = false
	play()
