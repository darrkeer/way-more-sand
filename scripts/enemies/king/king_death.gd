extends StateWithSpriteAnimation

@export var base_object : Node
@export var base : EnemyBase
@export var drop : PackedScene
@export var drop_probability : float = 0.3


func _drop_item() -> void:
	var d := drop.instantiate() as Node3D
	get_tree().current_scene.add_child(d)
	d.global_position = base.global_position


func exit() -> void:
	super()
	
	if randf() < drop_probability:
		_drop_item()
	
	base_object.queue_free()
