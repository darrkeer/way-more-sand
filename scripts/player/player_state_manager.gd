extends Node

var state : PlayerStateResource

func _ready() -> void:
	SaveManager.saving.connect(func():
		state.save_pos()	
	)
	
	await get_tree().process_frame
	
	state = SaveManager.save_data.player_state
	if state.spawn_on_spawnpoint:
		var t : Transform3D = SaveManager.get_node_state_by_id(state.spawnpoint_id).transform
		GameController.player_body.global_transform = t
		state.spawn_on_spawnpoint = false
	elif state.get_pos():
		GameController.player_body.global_transform = state.get_pos()
