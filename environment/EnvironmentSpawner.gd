extends Node

# Script that will be used to spawn plants and rocks inside the border limit

# Array that will contain the used positions
var used_positions = []

var iteration = 0

# Variables
export var plant_offset_x = 50
export var plant_offset_y = 50
export var rock_offset_x = 100
export var rock_offset_y = 100
export var tree_offset := Vector2(0,0)
export var plant_amount = 100
export var rock_amount = 200
export var tree_amount = 100

# Resources
onready var plant = preload("res://environment//Plant.tscn")
onready var rock = preload("res://environment//Rock.tscn")
onready var tree = preload("res://environment/Tree.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Call the function to spawn the plants
	spawn_plants()
	iteration = 0
	spawn_rocks()
	iteration = 0
	spawn_trees()
	pass # Replace with function body.

# Function that will instantiate the plants
func spawn_plants() -> void:
	# Get the random position
	var random_position = Vector2(rand_range(-Global.BORDER_X, Global.BORDER_X - plant_offset_x), rand_range(-Global.BORDER_Y, Global.BORDER_Y - plant_offset_y))

	# Check if the position is already used
	if used_positions.find(random_position) == -1:
		iteration += 1
		if iteration > plant_amount:
			return
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
		spawn_plants()
	
# Function that will instantiate the rocks
func spawn_rocks() -> void:
	# Get the random position
	var random_position = Vector2(rand_range(-Global.BORDER_X, Global.BORDER_X - rock_offset_x), rand_range(-Global.BORDER_Y, Global.BORDER_Y - rock_offset_y))
	# Check if the position is already used
	if used_positions.find(random_position) == -1:
		iteration += 1
		if iteration > rock_amount:
			return
		# Add the position to the used positions array
		used_positions.append(random_position)
		
		# Instantiate the rock
		var rock_instance = rock.instance()
		rock_instance.position = random_position
		add_child(rock_instance)
		
		# Call the function again
		spawn_rocks()
	else:
		# Call the function again
		spawn_rocks()

# Function that will instantiate the trees
func spawn_trees() -> void:
	# Get the random position
	var random_position = Vector2(rand_range(-Global.BORDER_X, Global.BORDER_X - tree_offset.x), rand_range(-Global.BORDER_Y, Global.BORDER_Y - tree_offset.y))
	# Check if the position is already used
	if used_positions.find(random_position) == -1:
		iteration += 1
		if iteration > tree_amount:
			return
		# Add the position to the used positions array
		used_positions.append(random_position)
		
		# Instantiate the tree
		var tree_instance = tree.instance()
		tree_instance.position = random_position
		add_child(tree_instance)
		
		# Call the function again
		spawn_trees()
	else:
		# Call the function again
		spawn_trees()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
