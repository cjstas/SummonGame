extends Node2D

#constants

#exports
@export var subPortal : PackedScene
@export var spawnRadius : int

#variables

var spawnIntervalModifier = 1.0;
var spawnCountdown = 0;
var spawning = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalController.deactivate_portal.connect(_on_portal_disabled)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !spawning:
		#do not pass go, do not collect delta
		return
		
	spawnCountdown -=delta
	if spawnCountdown <=0:
		spawn_enemy()
		spawnCountdown = spawnIntervalModifier * randf_range(0.1, 1.5)

#Functions
func spawn_enemy():
	var subPortalInstance = subPortal.instantiate()
	var x = randi_range(-spawnRadius, spawnRadius)
	var y = randi_range(-spawnRadius, spawnRadius)
	add_child(subPortalInstance)
	subPortalInstance.position = $SpawnLocation.position + Vector2(x, y)


func _on_spawn_trigger_area_entered(_area):
	$Timer.start()
	$PortalEffect.show()
	$SpawnTrigger.queue_free()

func _on_timer_timeout():
	spawning = true
	#Even though we are the portal, we need to do this for the Level Timer to Start
	SignalController.activate_portal.emit()

func _on_portal_disabled():
	spawning = false
	$PortalEffect.hide()
