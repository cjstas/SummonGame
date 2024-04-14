extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	GlobalVariables.timeLeft = $Timer.get_time_left()


func _on_timer_timeout():
	
	#Would be nice to have an animation for this (fade out or something)
	get_tree().change_scene_to_file("res://svc/scenes/action/action.tscn")
