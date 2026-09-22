class_name CameraController
extends Camera3D

@export var holder_x : Node3D
@export var holder_y : Node3D

const MIN_MOUSE_SPEED = 0.05
const MAX_MOUSE_SPEED = 2.0

const DEFAULT_SHAKE_FOV = 75
const MIN_SHAKE_FOV = 50

const MIN_Y_ANGLE : float = -70
const MAX_Y_ANGLE : float = 70

var mouse_captured : bool = false
var rotation_x : float = 0
var rotation_y : float = 0

var fov_tween : Tween

func camera_shake(force : float, time : float) -> void:
	var one_shake_time := 0.04
	while time > 0:
		time -= one_shake_time
		var v = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() / 10 * force
		await _tweak_cam(Vector3(v.x, v.y, 0), one_shake_time)

func _tweak_cam(dir : Vector3, time : float) -> void:
	var initial_pos : Vector3 = GameController.cam.position
	var t := GameController.create_tween()
	t.tween_method(func(x):
		GameController.cam.position = x,
		initial_pos,
		initial_pos + dir,
		time / 2.
	)
	await t.finished
	t = GameController.create_tween()
	t.tween_method(func(x):
		GameController.cam.position = x,
		initial_pos + dir,
		initial_pos,
		time / 2.
	)
	await t.finished

func _ready() -> void:
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if GameController.cam != null:
		push_error("singleton CameraController failed")
	GameController.cam = self

func _capture_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func get_mouse_speed_multiplier() -> float:
	return lerp(MIN_MOUSE_SPEED, MAX_MOUSE_SPEED, Settings.get_mouse_sens())

func change_fov(value : float, duration : float) -> void:
	if fov_tween and fov_tween.is_valid():
		fov_tween.kill()
	fov_tween = GameController.create_tween()
	fov_tween.tween_method(func(x):
		fov = x,
		fov,
		value,
		duration
	)
	fov_tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	fov_tween.set_ease(Tween.EASE_IN_OUT)
	await fov_tween.finished

func _rotate_camera(x : float, y : float):
	rotation_y -= x * get_mouse_speed_multiplier()
	rotation_x -= clamp(y * get_mouse_speed_multiplier(), MIN_Y_ANGLE, MAX_Y_ANGLE)
	
	holder_y.rotation_degrees.y = rotation_y
	holder_x.rotation_degrees.x = rotation_x


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		_capture_mouse()
		return
	
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		_rotate_camera(event.relative.x, event.relative.y)
		return
