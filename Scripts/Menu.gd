extends Control

var rt
export(AudioStreamOGGVorbis) var menu_audio
export(Resource) var next_scene

func _ready():
	rt = get_tree().get_root().get_node("RootNode")
	rt.call("load_audio_source", menu_audio)

func _on_BtnStart_pressed():
	rt.call("load_scene_additive", next_scene.resource_path)


func _on_BtnQuit_pressed():
	get_tree().quit()
