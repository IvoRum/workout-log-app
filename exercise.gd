class_name Excercise extends Node

@export var excercise_name: String
@export var description: String

func save():
	var save_disc ={
		"excercise_name": excercise_name,
		"description": description
	}
	
	return save_disc
