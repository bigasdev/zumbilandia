extends "res://characters/Npc.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2()

# Variables
export var max_followers := 10
var current_followers := 0

# Components
onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.player = self
	pass # Replace with function body.

func _moveInput():
	velocity = Vector2()
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	velocity = velocity.normalized() * (moveSpeed + PowerupManager.speed_powerup)
	pass

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
	_move(delta)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
