class_name MapStateResource
extends Resource

@export var pins : Dictionary[String, Array]

func _check_if_has_entry_for_this_scene() -> void:
	if SceneManager.current_scene not in pins:
		pins[SceneManager.current_scene] = []

func get_pins() -> Array[Vector2]:
	_check_if_has_entry_for_this_scene()
	return pins[SceneManager.current_scene]

func update_current_pins(p : Array[Vector2]) -> void:
	_check_if_has_entry_for_this_scene()
	pins[SceneManager.current_scene] = p

func update_pins(scene_name : String, p : Array[Vector2]) -> void:
	pins[scene_name] = p
