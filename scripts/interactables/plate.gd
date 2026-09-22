extends Interactable

@export var state : PlateStateResource

@export var player : AnimationPlayer
@export var pos : Node3D
@export var platforms : Array[MovingPlatform]

func _ready() -> void:
	if not SaveManager.get_node_state(self):
		SaveManager.register_node_state(self, PlateStateResource.new())
	state = SaveManager.get_node_state(self)
	
	await get_tree().process_frame
	if state.enabled:
		enable()

func enable() -> void:
	state.enabled = true
	player.play("rotate")
	AudioManager3D.play_sound_on_pos(pos.global_position, "radar")
	for p in platforms:
		p.start_moving()

func interact() -> void:
	if GameController.inventory.get_current_item().item_name == "remote":
		player.play("show")
		GameController.cam.camera_shake(0.3, 4)
		AudioManager3D.play_sound_on_pos(pos.global_position, "rumble")
		await player.animation_finished
		enable()
