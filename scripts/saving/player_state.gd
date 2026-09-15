class_name PlayerStateResource
extends Resource

@export var transforms : Dictionary[String, Transform3D]
@export var spawn_scene : String
@export var spawnpoint_id : String
@export var spawn_on_spawnpoint = false
@export var time_left : int

func save_pos() -> void:
	transforms[SceneManager.current_scene] = GameController.player_body.transform
	spawn_scene = SceneManager.current_scene

func get_pos():
	return transforms.get(SceneManager.current_scene)
