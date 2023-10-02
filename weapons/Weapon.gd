extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var damage : float
export var is_player_weapon : bool
export var radius : float = 5
export var cooldown : float = 0.15

onready var bulletPos = $BulletPos

# components
onready var bullet = preload("res://weapons/Bullet.tscn")
onready var timer : Timer = $Timer

var can_shoot := true

# Called when the node enters the scene tree for the first time.
func _ready():
	if is_player_weapon:
		timer.wait_time = cooldown
		pass
	pass # Replace with function body.

# Function that will set the damage of the weapon based in the character\
func set_damage(damage):
	self.damage = damage
	pass
	
# Function that will shoot the bullet
func shoot():
	if !can_shoot: return

	var bullet_instance = bullet.instance()
	
	if is_player_weapon:
		Global.camera.shake(0.05, 15, 11.1)
		Global.player_ammo -= 1
		
		if Global.player_ammo <= 0:
			return
		Global.hud.update_hud()
		pass
	
	get_node("/root/MainScene").add_child(bullet_instance)
	bullet_instance.direction = (get_global_mouse_position() - Global.player.global_position).normalized()
	bullet_instance.position = bulletPos.global_position
	can_shoot = false
	timer.start(cooldown)
	pass
	
func _rotate_mouse():
	var mouse_pos = get_global_mouse_position()
	var player_pos = Global.player.transform.origin
	var distance = player_pos.distance_to(mouse_pos) 
	var mouse_dir = (mouse_pos-player_pos).normalized()
	if distance > radius:
		mouse_pos = player_pos + (mouse_dir * radius)
	
	if mouse_dir.y <= -.35:
		z_index = -1
		pass
	else:
		z_index = 0
		pass
	global_transform.origin = mouse_pos
	if mouse_dir.x <= 0:
		flip_v = true
		pass
	else: 
		flip_v = false
		pass
	rotation = get_parent().get_local_mouse_position().angle() + 270
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !is_player_weapon: return
	
	if Input.is_action_just_pressed("player_shoot"): shoot()
	
	_rotate_mouse()
	pass


func _on_Timer_timeout():
	print_debug("finished")
	can_shoot = true
	pass # Replace with function body.
