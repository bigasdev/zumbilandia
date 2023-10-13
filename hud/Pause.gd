extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var settings = $SettingsMenu
onready var value_obj = $SettingsMenu/HSlider


# Called when the node enters the scene tree for the first time.
func _ready():
	value_obj.value = Global.volume
	print_debug(Global.volume)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Resume_pressed():
	print_debug("huh")
	StateManager.change_state(StateManager.States.UPDATE)
	queue_free()
	pass # Replace with function body.


func _on_Exit_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_Settings_pressed():
	settings.visible = true
	pass # Replace with function body.



func _on_Esc_pressed():
	settings.visible = false
	pass # Replace with function body.


func _on_Ok_pressed():
	settings.visible = false
	pass # Replace with function body.

func _on_HSlider_changed():
	pass # Replace with function body.


func _on_HSlider_drag_ended(value_changed:bool):
	pass # Replace with function body.


func _on_HSlider_value_changed(value:float):
	Global.volume = value
	print_debug(Global.volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), Global.volume)
	pass # Replace with function body.
