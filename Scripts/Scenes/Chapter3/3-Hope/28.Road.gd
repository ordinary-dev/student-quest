extends Node2D

const delay := 0.3

func show_notification() -> void:
	NOTIFY.show("ERROR")
	yield(get_tree().create_timer(delay), "timeout")
	NOTIFY.show("Unallocated memory access detected")
