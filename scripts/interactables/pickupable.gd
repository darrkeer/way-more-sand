class_name Pickupable
extends Interactable

@export var item : ItemResource

func interact() -> void:
	GameController.inventory.add_item(item)
	queue_free()
