extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var offset : Vector2
export var staticPos : bool
export var canRun : bool = true

export var health : int = 10
export var moveSpeed := 450
export var coins_to_drop := 3
export var damage := 5
export var closest_dist := 50
export var damage_dist := 30

# Components
onready var shoot_pos = $ShootPos
onready var shoot_timer = $Timers/Shoot
onready var animation = $AnimationPlayer
onready var animated_sprite = $Sprite
onready var focus = $Focus
onready var coin = preload("res://common/Coin.tscn")
onready var die_sound = $Die_Sound
onready var bullet = preload("res://weapons/BulletZombie.tscn")

var killed := false
var spawned := false
var can_shoot := false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if staticPos :
		return
	
	# get the multipliers
	moveSpeed += Global.round_zombie_speed_multiplier
	damage += Global.round_zombie_damage_multiplier
	coins_to_drop += Global.round_zombie_coins_multiplier
	health += Global.round_zombie_health_multiplier
	
	# get a random position based in an offset around the player
	position = Global.get_entity_rnd_radius(self, Vector2.ZERO, offset)
	animation.play("Spawn")
	animated_sprite.play("spawning")
	pass # Replace with function body.

func spawn():
	spawned = true
	#animated_sprite.play("idle")
	pass

func kill(drop:bool) -> void:
	if killed : return

	die_sound.play()
	killed = true
	Global.zombie_killed(self.global_position)
	if Global.closest_enemy == self:
		Global.closest_enemy = null
	if drop:
		var i = 0
		while i < coins_to_drop:
			var coin = self.coin.instance()
			coin.position = Global.get_entity_rnd_radius(self, Vector2.ZERO, Vector2(50,50))
			get_node("/root/MainScene/Game").add_child(coin)
			i += 1

# Function that will make the zombie run to the player
func chase(player : Node2D) -> void:
	if StateManager.game_running() == false:
		return

	if staticPos || !canRun:
		return

	animated_sprite.play("walking")
	var dir = (player.position - position).normalized()
	var velocity = dir * moveSpeed
	move_and_slide(velocity)

# Check if the player is inside the damage area
func player_on_range(dist:float) -> bool:
	if position.distance_to(Global.player.position) < dist:
		return true
	else:
		return false

# Function to attack the player, each zombie will have a different
func attack() -> void:
	if can_shoot : 
		shoot()
		can_shoot = false
	pass

func shoot() -> void:
	var bullet_instance = bullet.instance()
	bullet_instance.position = shoot_pos.global_position
	get_node("/root/MainScene").add_child(bullet_instance)

# Check if this zombie is the same as the global closest enemy
func is_closest_enemy() -> bool:
	if Global.closest_enemy == self:
		focus.enabled = true
		return true
	else:
		focus.enabled = false
		return false

func damage(dmg:int):
	if (!spawned && !staticPos) : return

	health -= dmg
	animation.play("Blink")
	if health <= 0:
		kill(true)
		pass
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if killed || !spawned: return

	if player_on_range(closest_dist) : Global.closest_enemy = self

	if StateManager.game_running():
		chase(Global.player)
		if player_on_range(damage_dist) && !staticPos:
			attack()
	pass


func _on_Die_Sound_finished():
	queue_free()
	pass # Replace with function body.


func _on_Shoot_timeout():
	can_shoot = true
	pass # Replace with function body.
