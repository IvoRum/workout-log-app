extends Control

@onready
var v_box_container: VBoxContainer = $MarginContainer/VBoxContainer
var exercises: Array[Excercise]
var exercise_data_path="res://data/Exercise.json"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_excercises()

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

func load_excercises() -> void:
	var save_file = FileAccess.open(exercise_data_path, FileAccess.READ)
	
	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()

		# Creates the helper class to interact with JSON.
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure.
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object.
		var node_data = json.data
		
		var exercise = Excercise.new()
		exercise.description = node_data["description"]
		exercise.excercise_name = node_data["excercise_name"]
		print("Created new exercise")
		
		var tekst = Label.new()
		tekst.text = exercise.excercise_name
		v_box_container.add_child(tekst)
		
		exercises.append(exercise)
		print("Appended list of exercises")

func create_and_save_excerice_exe() -> void:
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
