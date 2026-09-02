extends StateWithSpriteAnimation

@export var sprite : Sprite3D
@export var light : OmniLight3D
@export var base : EnemyBase

func enter(options := {}) -> void:
	super(options)
	
	sprite.shaded = true
	light.visible = false

func exit() -> void:
	super()
	
	sprite.shaded = false
	light.visible = true

func fixed_update(_delta : float) -> void:
	if base.distance_to_player() < base.INACTIVE_DISTANCE:
		state_machine.change_state("idle")
