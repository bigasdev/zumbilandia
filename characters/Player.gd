extends "res://characters/Npc.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2()

# Variables
export var max_followers := 10
var current_followers := 0
var is_moving := false

# Components
onready var animation = $AnimationPlayer
onready var dust_particle = preload("res://environment/particles/Walking_Particle.tscn")
onready var dust_right_pos = $Dust_Right
onready var dust_left_pos = $Dust_Left

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.player = self
	pass # Replace with function body.

func _moveInput():
	velocity = Vector2()
	if Input.is_action_pressed("move_right"):
		if position.x >= Global.BORDER_X : return
		sprite.flip_h = true
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		if position.x <= -Global.BORDER_X : return
		sprite.flip_h = false
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		if position.y <= -Global.BORDER_Y : return
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		if position.y >= Global.BORDER_Y : return
		velocity.y += 1
	velocity = velocity.normalized() * (moveSpeed + PowerupManager.speed_powerup)
	if velocity.x != 0 || velocity.y != 0:
		is_moving = true
	else:
		is_moving = false
	pass
	
func _move_animations() -> void:
	if is_moving:
		sprite.play("walking")
	else:
		sprite.play("idle")

func _move():
	move_and_slide(velocity)
	pass
	
# Called when collecting powerup/coins
func collect():
	animation.play("Collect")
	pass
	
# Called when rescuing an npc
func rescue(npc: KinematicBody2D) -> void:
	current_followers += 1
	if current_followers < max_followers:
		npc.set_following(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !StateManager.game_running(): return
	
	_moveInput()
	_move_animations()
	_move()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Function that will spawn the dust in the correct position and flip it based in the sprite.flip
func _spawn_dust() -> void:
	var dust = dust_particle.instance()
	get_node("/root/MainScene").add_child(dust)
	if sprite.flip_h:
		dust.position = dust_left_pos.global_position
	else:
		dust.flip_h = true
		dust.position = dust_right_pos.global_position
	dust.play("walking")
	pass

func _on_Dust_timeout():
	if is_moving:
		_spawn_dust()
		pass
	pass # Replace with function body.
