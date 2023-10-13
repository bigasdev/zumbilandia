extends Node

var main_scene
var camera
var player : KinematicBody2D
var spawner : Node
var hud : CanvasLayer
var closest_enemy : KinematicBody2D
var vendor : KinematicBody2D
var volume : float = 100

enum weapons {pistol, revolver, smg, ak, aug, negev}

var current_weapon = weapons.pistol

const BORDER_X : int = 2500
const BORDER_Y : int = 2500

var player_health : int = 100
var player_ammo : int = 200
var player_coins : int = 0
var round_number : int = 0
var round_zombie_multiplier : int = 1
var round_zombie_speed_multiplier : int = 0
var round_zombie_health_multiplier : int = 0
var round_zombie_damage_multiplier : int = 0
var round_zombie_coins_multiplier : int = 0
var weapon_number : int = 0

var kills_needed_to_chest : int = 25
var current_kills : int = 0

var rng = RandomNumberGenerator.new()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func reset():
	# Reset the variables
	player_health = 100
	player_ammo = 200
	player_coins = 0
	round_number = 0
	round_zombie_multiplier = 1
	round_zombie_speed_multiplier = 0
	round_zombie_health_multiplier = 0
	round_zombie_damage_multiplier = 0
	round_zombie_coins_multiplier = 0
	weapon_number = 0
	current_kills = 0
	closest_enemy = null
	hud.update_hud()

func night_time():
	round_number += 1
	if round_number % 2 == 0:
		round_zombie_multiplier += 1
	spawner.night_time()
	pass
	
func get_entity_rnd_radius(entity, radius=Vector2.ZERO, offset=Vector2.ZERO) -> Vector2:
	var vector = Vector2(radius.x, radius.y)
	rng.randomize()
	var offset_x = rng.randf_range(-offset.x, offset.x)
	var offset_y = rng.randf_range(-offset.y, offset.y)
	vector = Vector2(entity.global_position.x + offset_x, entity.global_position.y + offset_y)
	return vector
	

# Function to damage the player and check if its game over
func damage_player(damage) -> void:
	player_health -= damage
	Global.camera.shake(0.15, 15, 30.1)
	hud.update_hud()
	if player_health <= 0:
		game_over()

func zombie_killed(pos:Vector2=Vector2.ZERO) -> void:
	current_kills += 1
	if current_kills % kills_needed_to_chest == 0:
		spawner.spawn_chest(pos)
	hud.update_hud()

# Function for the game over
func game_over():
	print_debug("Game Over!")
	get_tree().reload_current_scene()
	pass

# Function that will increase the weapon number and change the current weapon to the next enum value if there is any
func next_weapon() -> void:
	if weapon_number <= weapons.negev:
		weapon_number += 1
		current_weapon = weapon_number
		print_debug(current_weapon)
		# Get all the nodes of the game that has the weapon.gd script
		var weapon_nodes = get_tree().get_nodes_in_group("weapon")
		# Loop through all the nodes and call the change_weapon function
		for node in weapon_nodes:
			node.change_weapon(current_weapon)
		hud.update_hud()

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
#	pass
