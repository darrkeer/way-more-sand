extends Node

const EFFECT_TIME = 1.0

@export var bar : TextureProgressBar

@export var scenes : Dictionary[String, PackedScene]
@export var initial_scene : String

var current_scene : String

func _ready() -> void:
	await get_tree().process_frame
	if SaveManager.save_data.player_state.spawn_scene:
		current_scene = SaveManager.save_data.player_state.spawn_scene
	else:
		current_scene = initial_scene
	load_scene(current_scene)

func load_scene(scene_name : String) -> void:
	if scene_name not in scenes:
		push_error("scene with name %s not found" % scene_name)
		return
	
	get_tree().paused = true
	await effect_in()
	get_tree().change_scene_to_packed(scenes[scene_name])
	current_scene = scene_name	
	await effect_out()
	get_tree().paused = false

func restart_scene() -> void:
	load_scene(current_scene)

func effect_in() -> void:
	var t := get_tree().create_tween()
	t.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	t.tween_property(bar, "value", 1, EFFECT_TIME)
	await t.finished

func effect_out() -> void:
	var t := get_tree().create_tween()
	t.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	t.tween_property(bar, "value", 0, EFFECT_TIME)
	await t.finished
