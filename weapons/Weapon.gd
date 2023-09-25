extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var damage : float
export var is_player_weapon : bool

var bulletPos : Position2D

# bullet object
onready var bullet = preload("res://weapons/Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Function that will set the damage of the weapon based in the character\
func set_damage(damage):
	self.damage = damage
	pass
	
# Function that will shoot the bullet
func shoot():
	var bullet_instance = bullet.instance()
	
	get_node("/root/MainScene").add_child(bullet_instance)
	bullet_instance.direction = (get_global_mouse_position() - Global.player.global_position).normalized()
	bullet_instance.position = bulletPos.global_position
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !is_player_weapon: return
	
	if Input.is_action_just_pressed("player_shoot"): shoot()
	
	look_at(get_global_mouse_position())
	pass
