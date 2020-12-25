extends Node

# Script to disable unavailable chapters.
# It looks strange, but I didn't find
# a better way to do it.
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

onready var _stages := [
	# Chapter 1
	$VBoxContainer/Chapter1/Beginning,           #0
	$VBoxContainer/Chapter1/FirstDays,           #1
	$VBoxContainer/Chapter1/Accident,            #2
	$VBoxContainer/Chapter1/Funeral,             #3
	# Chapter 2
	$VBoxContainer/Chapter2/NewBeginning,        #4
	$VBoxContainer/Chapter2/Celebration,         #5
	$VBoxContainer/Chapter2/Disappearance,       #6
	# Chapter 3
	$VBoxContainer/Chapter3/SecretSociety,       #7
	$VBoxContainer/Chapter3/Despair,             #8
	$VBoxContainer/Chapter3/Hope                 #9
]


func _ready() -> void:
	var index := 0
	for i in _stages:
		i.enabled = (index < SETTINGS.progress)
		index += 1
