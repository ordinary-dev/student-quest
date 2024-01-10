extends Node2D
class_name PoliceOfficerConfig

# Settings for officer_ai script
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

@export_node_path var nav_node = NodePath("../Navigation2D")
@export_node_path var upper_left_node
@export_node_path var bottom_right_node
@export_file("*.tscn") var restart_scene
