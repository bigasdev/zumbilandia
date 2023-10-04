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
onready var sound : AudioStreamPlayer = $Sound

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
func shoot(is_player:=true):
	if !can_shoot: return

	var bullet_instance = bullet.instance()
	if is_player: sound.play()

	print_debug(get_parent())
	
	if is_player_weapon:
		Global.player_ammo -= 1
		
		if Global.player_ammo <= 0:
			return
		Global.hud.update_hud()
		pass
	
	get_node("/root/MainScene").add_child(bullet_instance)
	if is_player : bullet_instance.direction = (get_global_mouse_position() - Global.player.global_position).normalized()
	else : 
		if Global.closest_enemy != null : bullet_instance.direction = (Global.closest_enemy.position - Global.player.global_position).normalized()
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

# Function that will rotate the weapon towards the Global.closesT_enemy if there is one
func _rotate_enemy():
	if Global.closest_enemy == null:
		return
	var enemy_pos = Global.closest_enemy.position
	var npc_pos = get_parent().transform.origin
	var distance = npc_pos.distance_to(enemy_pos) 
	var enemy_dir = (enemy_pos-npc_pos).normalized()
	if distance > radius:
		enemy_pos = npc_pos + (enemy_dir * radius)
	
	if enemy_dir.y <= -.35:
		z_index = -1
		pass
	else:
		z_index = 0
		pass
	global_transform.origin = enemy_pos
	if enemy_dir.x <= 0:
		flip_v = true
		pass
	else: 
		flip_v = false
		pass
	# Calculate an angle between the enemy and the weapon
	var angle = atan2(enemy_pos.y - npc_pos.y, enemy_pos.x - npc_pos.x)
    
    # Convert the angle to degrees
	angle = rad2deg(angle)
    
    # Set the rotation of the weapon node
	rotation_degrees = angle
	shoot(false)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().following == null && !is_player_weapon: return

	if !is_player_weapon:
		_rotate_enemy()
		return
	
	if Input.is_action_just_pressed("player_shoot"): shoot()
	
	_rotate_mouse()
	pass


func _on_Timer_timeout():
	print_debug("finished")
	can_shoot = true
	pass # Replace with function body.


func _on_Sound_finished():
	sound.stop()
	pass # Replace with function body.
