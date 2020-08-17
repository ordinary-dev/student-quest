# Script to disable unavailable chapters

# Copyright (c) 2020 PixelTrain
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

extends Node

onready var stages = [
	# Chapter 1
	$VBoxContainer/Chapter1/Beginning,           #0
	$VBoxContainer/Chapter1/FirstDay,            #1
	$VBoxContainer/Chapter1/UsualLife,           #2
	$VBoxContainer/Chapter1/Parting,             #3
	# Chapter 2
	$VBoxContainer/Chapter2/NewBeginning,        #5
	$VBoxContainer/Chapter2/Celebration,         #6
	$VBoxContainer/Chapter2/Journey,             #7
	$VBoxContainer/Chapter2/Memories,            #8
	# Chapter 3
	$VBoxContainer/Chapter3/SecretSociety,       #9
	$VBoxContainer/Chapter3/DailyLife,           #10
	$VBoxContainer/Chapter3/UnexpectedDecisions, #11
	# Chapter 4
	$VBoxContainer/Chapter4/IllusoryWorld,       #12
	$VBoxContainer/Chapter4/Escape,              #13
	$VBoxContainer/Chapter4/Infiltration         #14
]


func _ready() -> void:
	refresh()


func refresh() -> void:
	for i in range(GLOBAL.progress):
		stages[i].enabled = true
