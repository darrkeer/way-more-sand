extends Node

@export var label : Label

var cur_fade_tween : Tween
var prev_hint : HintResource

func _change_popup_opacity(value : float) -> void:
	label.modulate.a = value

func make_popup(hint : HintResource) -> void:
	if cur_fade_tween and cur_fade_tween.is_valid() and prev_hint and prev_hint.priority > hint.priority:
		return
	prev_hint = hint
	if cur_fade_tween and cur_fade_tween.is_valid():
		cur_fade_tween.kill()
	label.text = hint.text
	cur_fade_tween = get_tree().create_tween()
	cur_fade_tween.set_trans(Tween.TRANS_CUBIC)
	cur_fade_tween.tween_method(_change_popup_opacity, 1.0, 0.0, hint.show_time)
