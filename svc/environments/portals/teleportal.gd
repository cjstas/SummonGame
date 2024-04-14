extends Node2D

@export var sceneToPortTo : String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_portal_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file(sceneToPortTo)
