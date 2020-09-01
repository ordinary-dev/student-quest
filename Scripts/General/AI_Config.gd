# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Node2D

export (NodePath) var nav_node = NodePath("../Navigation2D")

export (NodePath) var upper_left_node
export (NodePath) var bottom_right_node

export (String, FILE, "*.tscn") var hit_scene_path
