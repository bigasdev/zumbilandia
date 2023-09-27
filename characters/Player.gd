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
onready var sprite := $Sprite
onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.player = self
	pass # Replace with function body.

func _moveInput():
	velocity = Vector2()
	if Input.is_action_pressed("move_right"):
		sprite.flip_h = true
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		sprite.flip_h = false
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	velocity = velocity.normalized() * (moveSpeed + PowerupManager.speed_powerup)
	if velocity.x != 0 || velocity.y != 0:
		is_moving = true
	else:
		is_moving = false
	pass
	
func _move_animations() -> void:
	print_debug(is_moving)
	if is_moving:
		sprite.play("walking")
	else:
		sprite.play("idle")

func _move(delta):
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
	_move(delta)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
