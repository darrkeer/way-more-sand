extends Node3D

func _ready() -> void:
	GameController.player_body.transform = transform
