extends Interactable

@export var state : DoorStateResource

func _ready() -> void:
	if SaveManager.get_node_state(self):
		state = SaveManager.get_node_state(self)
	else:
		SaveManager.register_node_state(self, state)

func _open() -> void:
	state.locked = false
	AudioManager3D.play_sound_on_pos(GameController.player_body.global_position, "door")
	SaveManager.save_data.player_state.spawnpoint_id = state.next_spawn_id
	SaveManager.save_data.player_state.spawn_on_spawnpoint = true
	SceneManager.load_scene(state.next_level)

func interact() -> void:
	if not state.locked:
		_open()
	elif GameController.inventory.get_current_item().item_name == "keys":
		GameController.inventory.remove_held_item()
		_open()
