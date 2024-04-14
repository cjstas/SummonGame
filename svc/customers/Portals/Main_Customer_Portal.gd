extends Node2D

#constants

#exports
@export var Table : PackedScene
@export var spawnRadius : int

#variables
var difficult = 1; #currently does nothing. Should be utilized to scale the Interval of spawning in some capacity.
var spawnIntervalModifier = 3;
var spawnCountdown = 1;
var spawning = false;

var maxTables = 5
var currentTables = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Interactable")
	SignalController.deactivate_portal.connect(_on_portal_disabled)
	SignalController.interact.connect(_on_interaction)
	SignalController.highlight.connect(_on_highlight)
	SignalController.banish_table.connect(_on_table_banished)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !spawning:
		#do not pass go, do not collect delta
		return
	
	spawnCountdown -=delta
	if spawnCountdown <=0 and currentTables < maxTables:
		spawn_customer()
		spawnCountdown = spawnIntervalModifier

#Functions
func spawn_customer():
	var x = randi_range(-spawnRadius, spawnRadius)
	var y = randi_range(-spawnRadius, spawnRadius)
	var tableInstance = Table.instantiate()
	get_parent().add_child(tableInstance)
	tableInstance.position = $SpawnLocation.global_position + Vector2(x, y)
	currentTables +=1


#Events

func _on_portal_disabled(): #I dont think this gets hit now
	spawning = false
	$PortalEffect.hide()

func _on_interaction(target, _value):
	if target==self:
		spawning = !spawning
		$PortalEffect.emitting = !$PortalEffect.emitting
		SignalController.activate_portal.emit()
		SignalController.kill_all_customers.emit()

func _on_highlight(target, highlighted):
	if target==self:
		GlobalVariables.highlight(target, highlighted, $Portal)

func _on_table_banished():
	currentTables -=1
