extends Control

export(AudioStreamOGGVorbis) var audio
export(Resource) var next_scene

func _ready():
	#get_node("Label").text = get_node("/root/global").date
	var rt = get_tree().get_root().get_node("RootNode")
	rt.call("load_audio_source", audio)
	if next_scene != null:
		rt.call("load_scene_additive", next_scene.resource_path, 3)
