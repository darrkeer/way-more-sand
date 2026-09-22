extends CharacterBody3D
class_name EnemyBase

const DAMAGE_HIT_EFFECT_TIME = 0.1

@export var VIEW_DISTANCE : float
@export var DAMAGE_RANGE : float
@export var INACTIVE_DISTANCE : float
@export var MOVE_SPEED : float
@export var ATTACK_RANGE : float
@export var MOVE_SOUND_DELAY : float
@export var BASE_HP : int
@export var BASE_DAMAGE : int
@export var WALK_SOUNDS : Array[String] 

@export var agent : NavigationAgent3D
@export var state_machine : StateMachine

var hp : int
var just_damaged : bool = false

func get_random_walk_sound() -> String:
	return WALK_SOUNDS.pick_random()

func get_damage(amount : int) -> void:
	hp -= amount
	just_damaged = true
	state_machine.change_state("damage")
	just_damaged = false

func _ready() -> void:
	GameController.create_repeat_timeout(MOVE_SOUND_DELAY).connect(func():
		if velocity != Vector3.ZERO:
			AudioManager3D.play_sound_on_pos(global_position, get_random_walk_sound())	
	)
	hp = BASE_HP

func distance_to_player() -> float:
	return (GameController.player_body.global_position - global_position).length()

func raycast_to(pos : Vector3):
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(
		global_position + Vector3.UP,
		pos
	)
	query.exclude = [self]
	var result = space_state.intersect_ray(query)
	
	return result.collider if result else null

func raycast_to_player() -> bool:
	return raycast_to(GameController.player_body.global_position + Vector3.UP) == GameController.player_body

func can_see_player() -> bool:
	return	distance_to_player() < VIEW_DISTANCE and raycast_to_player()

func can_attack_player() -> bool:
	return can_see_player() and distance_to_player() < ATTACK_RANGE

func move_to_target() -> void:
	var pos := agent.get_next_path_position()
	velocity = global_position.direction_to(pos) * MOVE_SPEED
