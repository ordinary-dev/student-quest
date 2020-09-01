# Script to disable unavailable chapters

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Node

onready var stages = [
	# Chapter 1
	$VBoxContainer/Chapter1/Beginning,           #0
	$VBoxContainer/Chapter1/FirstDay,            #1
	$VBoxContainer/Chapter1/UsualLife,           #2
	$VBoxContainer/Chapter1/Parting,             #3
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
	refresh()


func refresh() -> void:
	for i in range(GLOBAL.progress + 1):
		stages[i].enabled = true
