@tool
extends Node

@export var save_data : SaveResource

@export_tool_button("Generate save file") var generate_save_file_action = generate_save_file
func generate_save_file() -> void:
	ResourceSaver.save(save_data, "user://save_data.tres")

@export_tool_button("Dump save data") var dump_save_file_a = dump_save_file
func dump_save_file() -> void:
	var res := ResourceLoader.load("user://save_data.tres", "", ResourceLoader.CACHE_MODE_IGNORE) as SaveResource
	if res == null:
		push_warning("file not found")
		return
	var dict := _resource_to_dict(res)
	print(JSON.stringify(dict, "\t"))

func _resource_to_dict(res: Resource) -> Dictionary:
	var dict := {}
	for prop in res.get_property_list():
		if not (prop.usage & PROPERTY_USAGE_STORAGE):
			continue
		var value = res.get(prop.name)
		dict[prop.name] = _value_to_printable(value)
	return dict

func _value_to_printable(value):
	if value is Resource:
		return _resource_to_dict(value)
	elif value is Array:
		var arr := []
		for item in value:
			arr.append(_value_to_printable(item))
		return arr
	elif value is Dictionary:
		var d := {}
		for key in value.keys():
			d[str(key)] = _value_to_printable(value[key])
		return d
	elif value is Vector2 or value is Vector2i:
		return {"x": value.x, "y": value.y}
	elif value is Vector3 or value is Vector3i:
		return {"x": value.x, "y": value.y, "z": value.z}
	elif value is Color:
		return {"r": value.r, "g": value.g, "b": value.b, "a": value.a}
	else:
		return value
