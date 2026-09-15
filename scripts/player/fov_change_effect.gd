extends Node


func change_fov(value : float, duration : float) -> void:
	var before : float = GameController.cam.fov
	await GameController.cam.change_fov(value, duration / 2)
	GameController.cam.change_fov(before, duration / 2)
