extends Area3D


func _ready() -> void:
	body_entered.connect(func(body):
		if body.is_in_group("player"):
			SceneManager.restart_scene()
	)
