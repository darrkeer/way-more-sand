class_name PopupMessage
extends Node

@export var label : Label

var cur_fade_tween : Tween

func _ready() -> void:
	GameController.messages = self

func _change_popup_opacity(value : float) -> void:
	label.modulate.a = value

func make_popup(hint : HintResource) -> void:
	label.text = hint.text
	if cur_fade_tween and cur_fade_tween.is_valid():
		cur_fade_tween.kill()
	cur_fade_tween = get_tree().create_tween()
	cur_fade_tween.set_trans(Tween.TRANS_CUBIC)
	cur_fade_tween.tween_method(_change_popup_opacity, 1.0, 0.0, hint.show_time)
