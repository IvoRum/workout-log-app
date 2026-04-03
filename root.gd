extends Node

const EXERCISE = preload("uid://bvgaoxetvoa14")
@onready var menu = $Menu_Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_excercises_pressed() -> void:
	load_exercises()
	remove_child(menu)

func load_exercises() -> void:
	var excercise_instance = EXERCISE.instantiate()
	add_child(excercise_instance)
