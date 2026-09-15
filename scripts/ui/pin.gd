class_name Pin
extends TextureRect

@export var unseleceted_texture : Texture2D
@export var selected_texture : Texture2D

var selected = false

func _ready() -> void:
	mouse_entered.connect(func():
		selected = true
	)
	mouse_exited.connect(func():
		selected = false
	)

func _input(_event: InputEvent) -> void:
	if selected:
		texture = selected_texture
		if Input.is_action_pressed("ui_alt_clik"):
			AudioManager3D.play_sound_on_pos(GameController.player_body.global_position, "pin2")
			queue_free()
	else:
		texture = unseleceted_texture
