extends StateWithSpriteAnimation

@export var base_object : Node

func exit() -> void:
	super()
	
	base_object.queue_free()
