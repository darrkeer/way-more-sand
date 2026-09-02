extends CharacterBody3D

const MOVE_SOUND_DELAY = 0.5
const JUMP_FORCE = 2
const BALOON_JUMP_FORCE = 5

@export var stats : PlayerStats

var was_on_floor : bool

func _get_random_walk_sound() -> String:
	return "footstep" + str(randi_range(1, 3))

func _ready() -> void:
	GameController.player_body = self
	GameController.create_repeat_timeout(MOVE_SOUND_DELAY).connect(func():
		if velocity != Vector3.ZERO and is_on_floor():
			AudioManager3D.play_sound_on_pos(global_position, _get_random_walk_sound())
	)

func _physics_process(delta: float) -> void:
	var hor := Input.get_axis("move_left", "move_right")
	var ver := Input.get_axis("move_up", "move_down")
	var move_vec := global_basis * Vector3(hor, 0, ver) * delta * stats.MOVE_SPEED
	
	velocity.x = move_vec.x
	velocity.z = move_vec.z
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		if GameController.inventory.get_current_item().item_name == "balloon":
			velocity += Vector3.UP * BALOON_JUMP_FORCE
		else:
			velocity += Vector3.UP * JUMP_FORCE
	
	if not was_on_floor and is_on_floor():
		AudioManager3D.play_sound_on_pos(position, "fall")
		#AudioManager3D.play_sound_on_pos(global_position, _get_random_walk_sound())
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	was_on_floor = is_on_floor()
	
	move_and_slide()
