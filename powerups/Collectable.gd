extends Area2D

enum CollectableType {POWER = 0, SPEED = 1, AMMO = 2, HEART = 3}

export(CollectableType) var type
onready var boots_sprite = preload("res://powerups/Boots.png")
onready var sword_sprite = preload("res://powerups/Sword.png")
onready var heart_sprite = preload("res://powerups/Heart.png")
onready var ammo_sprite = preload("res://powerups/Ammo.png")
onready var collect_sound = $Collect_Sound

onready var collectable_sprite = $Sprite

var rng = RandomNumberGenerator.new()

# Polish
export var y_pos_limit : float = .5
export var float_speed : float = 3
export var random_pos_offset : Vector2

var original_y_pos : float
var y_pos : float = 0
var float_state_up = false

var collected := false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	original_y_pos = collectable_sprite.position.y
	_change_icon()
	pass # Replace with function body.

# Function that will be called in the start, it will change the powerup icon based in the type
func _change_icon():
	if type == CollectableType.POWER:
		collectable_sprite.texture = sword_sprite
		pass
	if type == CollectableType.SPEED:
		collectable_sprite.texture = boots_sprite
		pass
	if type == CollectableType.AMMO:
		collectable_sprite.texture = ammo_sprite
		pass
	if type == CollectableType.HEART:
		collectable_sprite.texture = heart_sprite
		pass
	pass
	
# Function to randomize the spawn
func randomize_spawn(rnd_pos:bool=false):
	if rnd_pos:
		rng.randomize()
		var offset_x = rng.randf_range(-random_pos_offset.x, random_pos_offset.x)
		var offset_y = rng.randf_range(-random_pos_offset.y, random_pos_offset.y)
		position = Global.player.position + Vector2(offset_x, offset_y)
		pass
	type = CollectableType.values()[randi() % CollectableType.size()]
	_change_icon()
	pass
	
# Function to determine the type
func set_type(type) -> void:
	self.type = CollectableType.values()[2]
	_change_icon()

func _move_coin(delta):
	if float_state_up:
		y_pos -= float_speed * delta
		if y_pos <= -y_pos_limit:
			float_state_up = false
			pass
		pass
	else :
		y_pos += float_speed * delta
		if y_pos >= y_pos_limit:
			float_state_up = true
			pass
		pass
	collectable_sprite.position = Vector2(collectable_sprite.position.x, original_y_pos + y_pos)
	pass
	
func collect():
	if collected : return

	collect_sound.play()
	collected = true
	collectable_sprite.visible = false
	if type == CollectableType.POWER:
		PowerupManager.power_powerup += 1
		pass
	if type == CollectableType.SPEED:
		PowerupManager.speed_powerup += 10
		pass
	if type == CollectableType.AMMO:
		Global.player_ammo += 50
		Global.hud.update_hud()
		pass
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_move_coin(delta)
	pass


func _on_Collectable_body_entered(body):
	if body.is_in_group("Player"):
		body.collect()
		collect()
		pass
	pass # Replace with function body.


func _on_Collect_Sound_finished():
	queue_free()
	pass # Replace with function body.
