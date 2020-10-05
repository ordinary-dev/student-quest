extends Control

export (String, FILE, "*.tscn") var edit_scene_path
export (String, FILE, "*.tscn") var delete_scene_path


func _on_Edit_pressed() -> void:
	FX.btn_click()
	SCENES.load_scene(edit_scene_path)


func _on_Delete_pressed() -> void:
	FX.btn_click()
	SCENES.load_scene(delete_scene_path)
