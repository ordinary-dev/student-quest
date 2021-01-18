extends Node2D
class_name PoliceOfficerConfig

# Settings for officer_ai script
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

export (NodePath) var nav_node = NodePath("../Navigation2D")
export (NodePath) var upper_left_node
export (NodePath) var bottom_right_node
export (String, FILE, "*.tscn") var restart_scene
