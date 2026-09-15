class_name Interactor
extends Node

const INTERACT_TIMEOUT = 0.5

@export var raycast : RayCast3D

var interacting_item : Interactable
var can_interact = true

func update_interacting_item(item : Interactable) -> void:
	if interacting_item == item:
		return
	interacting_item = item
	print("new interacting item : %s" % item.name)
	if interacting_item.hint:
		HintManager.make_popup(interacting_item.hint)

func remove_interacting_item() -> void:
	if interacting_item == null:
		return
	interacting_item = null

func _ready() -> void:
	GameController.interactor = self

func _interact() -> void:
	if not can_interact:
		return
	
	can_interact = false
	GameController.create_one_shot_timeout(INTERACT_TIMEOUT).connect(func():
		can_interact = true
		print("now can")
	)
	
	if interacting_item:
		interacting_item.interact()
	else:
		GameController.inventory.get_current_item().use()
	GameController.shake_effects.make_use_effect()

func _physics_process(_delta: float) -> void:
	if raycast.is_colliding() and raycast.get_collider() is Interactable:
		update_interacting_item(raycast.get_collider() as Interactable)
	else:
		remove_interacting_item()
	
	if Input.is_action_just_pressed("attack"):
		_interact()
