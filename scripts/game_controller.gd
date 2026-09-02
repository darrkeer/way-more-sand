extends Node

var player_body : CharacterBody3D
var inventory : Inventory
var interactor : Interactor
var messages : PopupMessage
var shake_effects : HandShakeEffects
var settings : Settings

var clocks : Clocks

func create_one_shot_timeout(wait_time : float) -> Signal:
	return get_tree().create_timer(wait_time).timeout

func create_repeat_timeout(wait_time : float) -> Signal:
	var timer := Timer.new()
	
	timer.wait_time = wait_time
	timer.one_shot = false
	add_child(timer)
	timer.start()
	
	return timer.timeout
