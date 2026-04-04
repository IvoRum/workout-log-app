class_name ExerciseListButton
extends Button

var exercise_name: String
signal change_exercise(exercise_name)

func _ready():
	self.pressed.connect(_emit_change_exrcise)

func _emit_change_exrcise() -> void:
	change_exercise.emit(exercise_name)
