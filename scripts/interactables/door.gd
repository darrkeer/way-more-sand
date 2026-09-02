extends Interactable

@export var next_level : String

func interact() -> void:
	if GameController.inventory.get_current_item().item_name == "keys":
		AudioManager3D.play_sound_on_pos(GameController.player_body.global_position, "door")
		GameController.inventory.remove_held_item()
		SceneManager.load_scene(next_level)
