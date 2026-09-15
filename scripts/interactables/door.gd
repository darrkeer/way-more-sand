extends Interactable

@export var next_level : String
@export var locked = true

func _ready() -> void:
	if SaveManager.get_node_state(self):
		locked = SaveManager.get_node_state(self).locked
	SaveManager.register_node_state(self, DoorStateResource.new())
	SaveManager.saving.connect(func():
		SaveManager.get_node_state(self).locked = locked
	)

func _open() -> void:
	locked = false
	SaveManager.save()
	AudioManager3D.play_sound_on_pos(GameController.player_body.global_position, "door")
	SceneManager.load_scene(next_level)

func interact() -> void:
	print("locked: ", locked)
	if not locked:
		_open()
	elif GameController.inventory.get_current_item().item_name == "keys":
		GameController.inventory.remove_held_item()
		_open()
