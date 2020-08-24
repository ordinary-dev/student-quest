# Settings script

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends TabContainer


# Change tabs name
func _ready() -> void:
	set_tab_title(0, "LANG")
	set_tab_title(1, "AUDIO")
	set_tab_title(2, "GRAPHICS")
	set_tab_title(3, "INFO")


# Button click
func _on_TabContainer_tab_changed(_tab):
	FX.btn_click()
