extends Node2D

@export var gremlin : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	#Randomize the timer within a range of 2-5 seconds
	$Timer.wait_time = randi_range(2, 5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_timer_timeout():
	#spawn Gremlin and attach to parent node
	var grem = gremlin.instantiate()
	SignalController.parent_enemy.emit(grem)
	grem.transform = global_transform
	#remove self
	queue_free()
	pass # Replace with function body.
