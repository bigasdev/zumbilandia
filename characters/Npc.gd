extends KinematicBody2D

export var moveSpeed : float
export var attackSpeed : float
export var damage : float

# components
onready var weapon : Sprite = $Weapon

#following variables
var following : KinematicBody2D
const SMOOTH_SPEED = 1
var position_difference = Vector2()
var smoothed_velocity = Vector2()

var attacking : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	following = Global.player
	if weapon :
		weapon.set_damage(damage)
		pass
	pass # Replace with function body.
	
# Function that will be used to make the npc follow the player
# or for the enemies to move towards the player
func move_to(pos, delta):
	position_difference = pos - position
	smoothed_velocity = position_difference * SMOOTH_SPEED * delta
	
	position += smoothed_velocity
	pass
	
func is_far_from(pos):
	if pos.distance_to(position) > 190:
		return true
	else:
		return false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if StateManager.game_running():
		if following:
			if is_far_from(following.position):
				move_to(following.position, delta)
			pass
	pass
	
	pass
