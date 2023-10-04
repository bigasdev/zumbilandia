extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed : float = 15
export var direction : Vector2
var velocity : Vector2

# Variables
export var life_timer := 3
onready var hit_particle = preload("res://environment/particles/Hit_Particle.tscn")

# private
var life_time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _move_bullet(delta):
	velocity = speed *direction * delta
	translate(velocity)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	_move_bullet(delta)
	pass
	
func _process(delta) -> void:
	life_time += 1 * delta
	if life_time >= life_timer:
		queue_free()

func _on_Bullet_body_entered(body):
	print_debug(body)
	if body.is_in_group("Zombie"):
		# Instantiate the hit effect
		var hit_effect = hit_particle.instance()
		get_parent().add_child(hit_effect)
		hit_effect.play("idle")
		hit_effect.position = body.global_position

		body.damage(Global.player.damage + PowerupManager.power_powerup)
		queue_free()
		pass
	if body.is_in_group("Breakable"):
		var hit_effect = hit_particle.instance()
		get_parent().add_child(hit_effect)
		hit_effect.play("idle")
		hit_effect.position = body.global_position

		body.destroy()
		queue_free()
		pass
	pass # Replace with function body.

