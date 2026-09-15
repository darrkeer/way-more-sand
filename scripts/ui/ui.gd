class_name UI
extends Control

const FADE_DURATION = 0.2;

@export var back_panel : CanvasItem
@export var menus : Dictionary[String, Control]
@export var hud : Control

var current_menu : String
var fade_tween : Tween

func _fade_to(from : float, to : float) -> void:
	if fade_tween:
		fade_tween.kill()
	back_panel.material.set_shader_parameter("opacity", from)
	fade_tween = create_tween()
	fade_tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	fade_tween.tween_method(func(x):
		back_panel.material.set_shader_parameter("opacity", x)
	, from, to, FADE_DURATION)

func pause_and_open_ui(ui_name : String) -> void:
	if ui_name not in menus:
		push_error("could not find a menu with name: %s" % ui_name)
		return
	if current_menu:
		menus[current_menu].hide()
	current_menu = ui_name
	get_tree().paused = true
	menus[current_menu].show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	hud.hide()
	_fade_to(0, 1)

func resume_game() -> void:
	get_tree().paused = false
	if current_menu:
		menus[current_menu].hide()
	hud.show()
	_fade_to(1, 0)

func _ready() -> void:
	resume_game()
	if GameController.ui:
		push_error("singleton UI error")
	GameController.ui = self

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused:
			resume_game()
		else:
			pause_and_open_ui("pause")
