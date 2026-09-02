extends Interactable

@export var enabled_light : Node3D
@export var disabled_light : Node3D
@export var text : String
@export var label : Label3D

var is_enabled = false
var audio_player : AudioPlayer3D

func _ready() -> void:
	label.text = text
	enabled_light.visible = is_enabled
	disabled_light.visible = not is_enabled

func interact() -> void:
	if GameController.inventory.get_current_item().item_name == "remote":
		is_enabled = not is_enabled
		enabled_light.visible = is_enabled
		disabled_light.visible = not is_enabled
		
		if is_enabled:
			AudioManager3D.play_sound_on_pos(label.global_position, "tv_enable")
			audio_player = AudioManager3D.play_sound_on_pos(label.global_position, "tv_static")
		else:
			audio_player.stop_sound()
			AudioManager3D.play_sound_on_pos(label.global_position, "tv_disable")
		# sound
		# effects
		# text
