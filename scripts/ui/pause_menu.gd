extends Node

@export var delete_checkboxes : Array[CheckBox]
@export var other_button : Button
@export var back_button : Button

@export var other_menu : Control
@export var main_menu : Control

func _check_delete(_toggled_on: bool) -> void:
	var cnt := 0
	for c in delete_checkboxes:
		if c.button_pressed:
			cnt += 1
	print("cnt: ", cnt)
	if cnt == delete_checkboxes.size():
		SaveManager.erase_data()

func _reset_checkboxes() -> void:
	for c in delete_checkboxes:
		c.button_pressed = false

func _ready() -> void:
	for c in delete_checkboxes:
		c.toggled.connect(_check_delete)
	other_button.pressed.connect(func():
		other_menu.visible = true
		main_menu.visible = false
	)
	back_button.pressed.connect(func():
		other_menu.visible = false
		main_menu.visible = true
	)
	other_menu.visibility_changed.connect(_reset_checkboxes)
