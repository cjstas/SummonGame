extends Node2D

@export var teleportal : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalController.parent_enemy.connect(_on_parent_enemy)
	SignalController.activate_portal.connect(_on_portal_activated)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta): 
	GlobalVariables.timeLeft = $Timer.get_time_left()


func _on_timer_timeout():
	var teleporter = teleportal.instantiate()
	add_child(teleporter)
	teleporter.position = $TeleportalSpawn.position
	SignalController.deactivate_portal.emit()

func _on_parent_enemy(enemy):
	$Enemies.add_child(enemy)

func _on_portal_activated():
	$Timer.start()
	$Tutorial.queue_free()
