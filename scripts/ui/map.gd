extends Control

const PIN_DELAY = 0.2

@export var pin : PackedScene
@export var pin_holder : Node

var can_place_pin = false

func _ready() -> void:
	visibility_changed.connect(func():
		if visible:
			load_pins()
			GameController.create_one_shot_timeout(PIN_DELAY).connect(func():
				can_place_pin = true
			)
		else:
			dump_pins()
			can_place_pin = false
	)

func dump_pins() -> void:
	var res : Array[Vector2] = []
	for c in pin_holder.get_children():
		var pos := (c as Control).global_position
		res.append(pos)
	SaveManager.save_data.MAPS_DATA.update_current_pins(res)

func load_pins() -> void:
	for c in pin_holder.get_children():
		print("deleting ", c.name)
		c.queue_free()
	for v in SaveManager.save_data.MAPS_DATA.get_pins():
		_spawn_pin(v)

func _spawn_pin(pos : Vector2) -> void:
	var new_pin := pin.instantiate()
	new_pin.global_position = pos
	pin_holder.add_child(new_pin)

func _input(_event: InputEvent) -> void:
	if can_place_pin and Input.is_action_just_pressed("ui_click"):
		# TODO: maybe fix offset
		AudioManager3D.play_sound_on_pos(GameController.player_body.global_position, "pin1")
		_spawn_pin(get_global_mouse_position() - Vector2(10, 10))
