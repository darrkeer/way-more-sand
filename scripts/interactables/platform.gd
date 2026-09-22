class_name MovingPlatform
extends AnimatableBody3D

@export var points: Array[Node3D]
@export var time_for_one_move : float

var current_point = -1
var timer : Timer
var desired_speed : float

func get_dest() -> Vector3:
	return points[current_point].global_position

func recalc_speed() -> void:
	desired_speed = (global_position - get_dest()).length() / time_for_one_move

func start_moving() -> void:
	current_point = 0
	recalc_speed()
	GameController.create_repeat_timeout(time_for_one_move).connect(func():
		current_point = (current_point + 1) % points.size()
		recalc_speed()
	)

func _physics_process(delta: float) -> void:
	if current_point == -1:
		return
	
	global_position = global_position.move_toward(get_dest(), desired_speed * delta)
