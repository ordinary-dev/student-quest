extends Control

export(Resource) var first_scene
var scene_container
var audio_player

# audiores - loaded audio resource
func load_audio_source(audiores):
	if audio_player.stream != audiores:
		audio_player.stream = audiores
	if not audio_player.playing:
		audio_player.play()

func load_scene_additive(path, delay = 0):
	if delay != 0:
		yield(get_tree().create_timer(delay), "timeout")

	# Remove the current level
	var level = scene_container
	for n in level.get_children():
		level.remove_child(n)
		n.queue_free()

	# Add the next level
	var next_level_resource = load(path)
	var next_level = next_level_resource.instance()
	scene_container.add_child(next_level)


func _ready():
	scene_container = get_node("SceneRoot")
	audio_player = get_node("AudioStreamPlayer")
	load_scene_additive(first_scene.resource_path)