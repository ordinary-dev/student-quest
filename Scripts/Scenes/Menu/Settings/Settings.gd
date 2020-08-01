# Settings script

# Copyright (c) 2020 PixelTrain
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

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
