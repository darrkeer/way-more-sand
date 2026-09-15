class_name Pickupable
extends Interactable

@export var item : ItemResource

func _ready() -> void:
	if not SaveManager.get_node_state(self):
		SaveManager.register_node_state(self, BaseNodeStateResource.new())
	if SaveManager.get_node_state(self).expired:
		queue_free()

func interact() -> void:
	GameController.inventory.add_item(item)
	SaveManager.get_node_state(self).expired = true
	queue_free()
