extends Interactable

@export var particles : GPUParticles3D
@export var body : Node3D

var state = BaseNodeStateResource

func _ready() -> void:
	if not SaveManager.get_node_state(self):
		SaveManager.register_node_state(self, BaseNodeStateResource.new())
	state = SaveManager.get_node_state(self)
	
	if state.expired:
		body.queue_free()

func interact() -> void:
	if GameController.inventory.get_current_item().item_name == "knife":
		particles.emitting = true
		state.expired = true
		AudioManager3D.play_sound_on_pos(body.global_position, "crystal_break")
		body.queue_free()
