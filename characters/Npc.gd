extends KinematicBody2D

export var moveSpeed : float
export var attackSpeed : float
export var damage : int
export var player_range : float = 100

# components
onready var weapon : Sprite = $Weapon
onready var sprite := $YSort/Sprite

#following variables
var following : KinematicBody2D
const SMOOTH_SPEED = 1
var position_difference = Vector2()
var smoothed_velocity = Vector2()

var attacking : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if weapon :
		weapon.set_damage(damage)
		pass
	pass # Replace with function body.
	
# Function that will be used to make the npc follow the player
# or for the enemies to move towards the player
func move_to(pos, delta):
	# Move it with kinematic so it has collision
	position_difference = pos - position
	smoothed_velocity = smoothed_velocity.linear_interpolate(position_difference, SMOOTH_SPEED * delta)
	move_and_slide(smoothed_velocity)
	pass
	
func is_far_from(pos):
	if pos.distance_to(position) > player_range:
		return true
	else:
		sprite.play("idle")
		return false

func set_following(character):
	following = character
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if StateManager.game_running():
		if following:
			if is_far_from(following.position):
				move_to(following.position, delta)
			pass
	pass
	
	pass
