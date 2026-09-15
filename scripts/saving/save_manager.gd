extends Node

@export var saving_hint : HintResource
@export var save_data : SaveResource
@export var base_save_data : SaveResource

# only use if cant hold a state within an object 
signal saving

func _ready() -> void:
	save_data = base_save_data
	load_save()

func generate_node_uid(n : Node) -> String:
	return SceneManager.current_scene + "::" + str(n.get_path())

func get_node_state(n : Node):
	return get_node_state_by_id(generate_node_uid(n))

func get_node_state_by_id(id : String):
	if id not in save_data.node_states:
		return null
	return save_data.node_states[id]

func register_node_state(n : Node, state):
	var obj_name := generate_node_uid(n)
	if obj_name in save_data.node_states:
		push_error("state is already written on obj: ", obj_name)
		return
	save_data.node_states[obj_name] = state

func load_save() -> void:
	if FileAccess.file_exists("user://save_data.tres"):
		save_data = ResourceLoader.load("user://save_data.tres", "", ResourceLoader.CACHE_MODE_REPLACE) as SaveResource
	_dump_expired()

func _dump_expired() -> void:
	print("currently expired nodes:")
	for n in save_data.node_states:
		print(n, ": expired = ", save_data.node_states[n].expired)

func save() -> void:
	saving.emit()
	ResourceSaver.save(save_data, "user://save_data.tres")
	HintManager.make_popup(saving_hint)

func erase_data() -> void:
	# TODO: isnt working
	if FileAccess.file_exists("user://save_data.tres"):
		DirAccess.remove_absolute("user://save_data.tres")
	save_data = base_save_data
	SceneManager.load_scene(SceneManager.initial_scene)
