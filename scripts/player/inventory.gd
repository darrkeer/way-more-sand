class_name Inventory
extends Node

@export var holding_item_rect : TextureRect

@export var inventory : Array[ItemResource]
var holding_item_index : int = 0

func _ready() -> void:
	GameController.inventory = self

func add_item(item : ItemResource) -> void:
	inventory.append(item)
	holding_item_index = inventory.size() - 1
	_update_holding_item()

func remove_held_item() -> bool:
	if get_current_item().item_name == "empty":
		return false
	_prev_item()
	inventory.remove_at((holding_item_index + 1) % inventory.size())
	return true

func _next_item() -> void:
	holding_item_index = (holding_item_index + 1) % inventory.size()
	_update_holding_item()

func _prev_item() -> void:
	holding_item_index -= 1
	if holding_item_index < 0:
		holding_item_index += inventory.size()
	_update_holding_item()

func get_current_item() -> ItemResource:
	return inventory[holding_item_index]

func _update_holding_item() -> void:
	var item := get_current_item()
	holding_item_rect.texture = item.image
	if item.pickup_sound_name:
		AudioManager3D.play_sound_on_pos(GameController.player_body.global_position, item.pickup_sound_name)
	if item.hint_message:
		GameController.messages.make_popup(item.hint_message)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
		_prev_item()
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
		_next_item()
