extends Node2D

#constants

#exports
@export var Table : PackedScene
@export var spawnRadius : int

#variables
var difficult = 1; #currently does nothing. Should be utilized to scale the Interval of spawning in some capacity.
var spawnIntervalModifier = 7;
var spawnCountdown = 1;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawnCountdown -=delta
	if spawnCountdown <=0:
		spawn_customer()
		spawnCountdown = spawnIntervalModifier

#Functions
func spawn_customer():
	var markerLocation = $SpawnLocation.global_transform
	var x = randi_range(-spawnRadius, spawnRadius)
	var y = randi_range(-spawnRadius, spawnRadius)
	var tableInstance = Table.instantiate()
	get_parent().add_child(tableInstance)
	tableInstance.position = $SpawnLocation.global_position + Vector2(x, y)
