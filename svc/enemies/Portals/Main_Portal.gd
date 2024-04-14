extends Node2D

#constants

#exports
@export var Enemy : PackedScene

#variables
var difficult = 1; #currently does nothing. Should be utilized to scale the Interval of spawning in some capacity.
var spawnIntervalModifier = 1;
var spawnCountdown = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawnCountdown -=delta
	if spawnCountdown <=0:
		spawn_enemy()
		spawnCountdown = spawnIntervalModifier

#Functions
func spawn_enemy():
	var enemyInstance = Enemy.instantiate()
	owner.add_child(enemyInstance)
	enemyInstance.transform = $SpawnLocation.global_transform
