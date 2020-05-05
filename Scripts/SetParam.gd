extends Node

export (String) var param
export (String) var value

func _ready():
	PROP.set(param, value)
