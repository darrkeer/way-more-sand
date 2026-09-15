extends Interactable

@export var particles : GPUParticles3D
@export var body : Node3D

func interact() -> void:
	if GameController.inventory.get_current_item().item_name == "knife":
		particles.emitting = true
		AudioManager3D.play_sound_on_pos(body.global_position, "crystal_break")
		body.queue_free()
