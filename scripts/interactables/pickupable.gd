class_name Pickupable
extends Interactable

@export var item : ItemResource

var state : BaseNodeStateResource

func _ready() -> void:
	if SaveManager.get_node_state(self):
		state = SaveManager.get_node_state(self)
	else:
		state = BaseNodeStateResource.new()
		SaveManager.register_node_state(self, state)
	if state.expired:
		queue_free()

func interact() -> void:
	GameController.inventory.add_item(item)
	state.expired = true
	queue_free()
