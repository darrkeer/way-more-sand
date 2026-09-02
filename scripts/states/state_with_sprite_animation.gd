extends State
class_name StateWithSpriteAnimation

@export var player : AnimatedSprite3D
@export var animation_name : String

func enter(_options := {}) -> void:
	super()
	player.play(animation_name)
