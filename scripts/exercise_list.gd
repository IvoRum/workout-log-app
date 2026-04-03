extends Control

@onready
var v_box_container: VBoxContainer = $MarginContainer/VBoxContainer
var exercises: Array[Excercise]
var exercise_data_path="res://data/Exercise.tres"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var load_file = FileAccess.open(exercise_data_path, FileAccess.READ)
	
	var exercise = Excercise.new()
	exercise.description = "description"
	exercise.excercise_name = "push up"
	print("Created new exercise")
	
	var tekst = Label.new()
	tekst.text = exercise.excercise_name
	v_box_container.add_child(tekst)
	
	exercises.append(exercise)
	print("Appended list of exercises")
	save_exercises()

func save_exercises() -> void:
	var save_file = FileAccess.open(exercise_data_path, FileAccess.WRITE)
	for exercise in exercises:
		
		# Check the node has a save function.
		if !exercise.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % exercise.name)
			continue
		
		# Call the node's save function.
		var node_data = exercise.call("save")
		# JSON provides a static method to serialized JSON string.
		var json_string = JSON.stringify(node_data)
		# Store the save dictionary as a new line in the save file.
		save_file.store_line(json_string)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
