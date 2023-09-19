extends "res://characters/Npc.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2()

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
	velocity = velocity.normalized() * moveSpeed
	pass

func _move(delta):
	move_and_slide(velocity)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !StateManager.game_running(): return
	
	_moveInput()
	_move(delta)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
