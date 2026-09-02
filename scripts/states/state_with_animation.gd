extends State
class_name StateWithAnimation

@export var animation_player : AnimationPlayer
@export var animation_name : String

func enter(_options := {}) -> void:
	super()
	animation_player.play(animation_name)
