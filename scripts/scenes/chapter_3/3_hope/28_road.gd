extends Node2D

# Show fake error messages
# when approaching the computer
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

const DELAY := 0.3


func show_notification() -> void:
	NOTIFY.show("ERROR")
	yield(get_tree().create_timer(DELAY), "timeout")
	NOTIFY.show("Unallocated memory access detected")
