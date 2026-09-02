extends Control

@export var game_ui : Control

func pause_game() -> void:
	get_tree().paused = true
	show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	game_ui.hide()

func resume_game() -> void:
	get_tree().paused = false
	hide()
	game_ui.show()

func _ready() -> void:
	resume_game()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused:
			resume_game()
		else:
			pause_game()
