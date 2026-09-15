extends Node3D

var state : SpawnPointResource

func _ready() -> void:
	if SaveManager.get_node_state(self):
		state = SaveManager.get_node_state(self)
	else:
		state = SpawnPointResource.new()
		SaveManager.register_node_state(self, state)
	
	state.transform = global_transform
