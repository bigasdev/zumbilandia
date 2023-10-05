extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# The object we need to instante
export var night_time_amount = 25
export var rescue_offset := Vector2(0,0)
# Modifiers
export var zombie_speed := 15
export var coins_to_drop := 1
export var damage := 3
export var health := 1

# Components
onready var zombie_timer = $Timer
onready var night_timer = $NightTimer

# Resources 
onready var rescue = preload("res://characters/Rescue.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.spawner = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	if !StateManager.game_can_spawn(): return
	
	var i = 0
	while i < Global.round_zombie_multiplier:
		var zombie = preload("res://enemies/Zombie.tscn")
		add_child(zombie.instance())
		i+=1
	pass # Replace with function body.


func night_time():
	var i = 0
	StateManager.change_state(StateManager.States.UPDATE_IDLE)
	night_timer.start()
	spawn_rescue()
	while i < night_time_amount:
		var zombie = preload("res://enemies/Zombie.tscn")
		add_child(zombie.instance())
		i += 1
	night_time_amount += 20
	pass

# Function that will spawn the rescue randomly with an offset from the player
func spawn_rescue():
	var offset = Vector2(rand_range(-rescue_offset.x, rescue_offset.x), rand_range(-rescue_offset.y, rescue_offset.y))
	var rescue_instance = rescue.instance()
	rescue_instance.position = Global.get_entity_rnd_radius(Global.player, Vector2.ZERO, offset)
	add_child(rescue_instance)
	pass


func _on_NightTimer_timeout():
	print_debug("Reseting the update method")
	Global.main_scene.counter_timer.start()
	Global.round_zombie_coins_multiplier += coins_to_drop
	Global.round_zombie_damage_multiplier += damage
	Global.round_zombie_health_multiplier += health
	Global.round_zombie_speed_multiplier += zombie_speed
	if zombie_timer.wait_time >= 0.2 : zombie_timer.wait_time -= 0.1
	StateManager.set_update()
	pass # Replace with function body.
