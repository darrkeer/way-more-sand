class_name InventoryManager
extends Node

@export var holding_item_rect : TextureRect

var inventory : InventoryResource

func _ready() -> void:
	GameController.inventory = self
	inventory = SaveManager.save_data.inventory

func add_item(item : ItemResource) -> void:
	inventory.items.append(item)
	inventory.holding_item_index = inventory.items.size() - 1
	_update_holding_item()

func remove_held_item() -> bool:
	if get_current_item().item_name == "empty":
		return false
	_prev_item()
	inventory.items.remove_at((inventory.holding_item_index + 1) % inventory.items.size())
	return true

func _next_item() -> void:
	inventory.holding_item_index = (inventory.holding_item_index + 1) % inventory.items.size()
	_update_holding_item()

func _prev_item() -> void:
	inventory.holding_item_index -= 1
	if inventory.holding_item_index < 0:
		inventory.holding_item_index += inventory.items.size()
	_update_holding_item()

func get_current_item() -> ItemResource:
	return inventory.items[inventory.holding_item_index]

func _update_holding_item() -> void:
	var item := get_current_item()
	holding_item_rect.texture = item.image
	if item.pickup_sound_name:
		AudioManager3D.play_sound_on_pos(GameController.player_body.global_position, item.pickup_sound_name)
	if item.hint_message:
		HintManager.make_popup(item.hint_message)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
		_prev_item()
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
		_next_item()
