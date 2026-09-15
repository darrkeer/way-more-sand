class_name MapResource
extends ItemResource

func use() -> void:
	GameController.ui.pause_and_open_ui("map")
