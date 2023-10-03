extends Node

# Script that will be used to spawn plants and rocks inside the border limit

# Array that will contain the used positions
var used_positions = []

var iteration = 0

# Variables
export var plant_offset_x = 50
export var plant_offset_y = 50
export var plant_amount = 100

# Resources
onready var plant = preload("res://Environment//Plant.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Call the function to spawn the plants
	spawn_plants()
	pass # Replace with function body.

# Function that will instantiate the plants
func spawn_plants() -> void:
	iteration += 1
	if iteration > plant_amount:
		return
	# Get the random position
	var random_position = Vector2(rand_range(-Global.BORDER_X, Global.BORDER_X - plant_offset_x), rand_range(-Global.BORDER_Y, Global.BORDER_Y - plant_offset_y))
	# Check if the position is already used
	if used_positions.find(random_position) == -1:
		# Add the position to the used positions array
		used_positions.append(random_position)
		
		# Instantiate the plant
		var plant_instance = plant.instance()
		plant_instance.position = random_position
		add_child(plant_instance)
		
		# Call the function again
		spawn_plants()
	else:
		# Call the function again
		print_debug("calling")
		spawn_plants()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
