extends Interactable

const TIME_TO_ADD : int = 90

func interact() -> void:
	if GameController.inventory.get_current_item().item_name == "sand":
		GameController.clocks.add_time(TIME_TO_ADD)
		GameController.inventory.remove_held_item()
		AudioManager3D.play_sound_on_pos(GameController.player_body.global_position, "clocks_add")
		SaveManager.save()
